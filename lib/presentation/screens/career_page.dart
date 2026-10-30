import 'package:flutter/material.dart';

import '../repositories/experiences.dart';
import '../widgets/career/career_menu.dart';
import '../widgets/career/career_step.dart';
import '../widgets/framework/frameworks_section.dart';
import '../widgets/career/career_header.dart';

class CareerPage extends StatefulWidget {
  const CareerPage({super.key});

  @override
  State<CareerPage> createState() => _CareerPageState();
}

class _CareerPageState extends State<CareerPage> {
  // Décalage entre le bas de la topbar et l'expérience ciblée après un clic.
  static const _scrollGap = 24.0;
  // Une expérience devient active un peu avant d'atteindre sa position cible.
  static const _activationMargin = 40.0;
  static const _menuMinWidth = 960.0;

  final _scrollController = ScrollController();
  final _stepKeys = List.generate(experiences.length, (_) => GlobalKey());

  int _activeStep = 0;
  bool _isScrollingToStep = false;
  int _scrollRequest = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateActiveStep);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  double? _stepTop(int index) {
    final box =
        _stepKeys[index].currentContext?.findRenderObject() as RenderBox?;
    return box?.localToGlobal(Offset.zero).dy;
  }

  void _updateActiveStep() {
    // Pendant un scroll lancé par un clic, le menu garde l'expérience choisie.
    if (_isScrollingToStep) return;

    final activationLine =
        MediaQuery.paddingOf(context).top + _scrollGap + _activationMargin;
    var active = 0;
    for (var index = 0; index < _stepKeys.length; index++) {
      final top = _stepTop(index);
      if (top != null && top <= activationLine) active = index;
    }
    if (active != _activeStep) setState(() => _activeStep = active);
  }

  Future<void> _scrollToStep(int index) async {
    final top = _stepTop(index);
    if (top == null) return;

    final request = ++_scrollRequest;
    setState(() {
      _activeStep = index;
      _isScrollingToStep = true;
    });

    final position = _scrollController.position;
    final target =
        (position.pixels + top - MediaQuery.paddingOf(context).top - _scrollGap)
            .clamp(position.minScrollExtent, position.maxScrollExtent);

    if (MediaQuery.disableAnimationsOf(context)) {
      _scrollController.jumpTo(target);
    } else {
      await _scrollController.animateTo(
        target,
        duration: const Duration(milliseconds: 550),
        curve: Curves.easeInOutCubic,
      );
    }

    if (!mounted || request != _scrollRequest) return;
    _isScrollingToStep = false;
    _updateActiveStep();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final showMenu = size.width >= _menuMinWidth;

    final content = SingleChildScrollView(
      controller: _scrollController,
      // Le padding haut de MediaQuery inclut la hauteur de la topbar.
      padding: EdgeInsets.fromLTRB(
        24,
        MediaQuery.paddingOf(context).top + 48,
        24,
        // Laisse assez de hauteur pour amener la dernière expérience en haut.
        showMenu ? size.height * 0.65 : 64,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 680),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CareerHeader(),
              const SizedBox(height: 64),
              Text('Parcours', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 24),
              for (final (index, experience) in experiences.indexed)
                CareerStep(key: _stepKeys[index], experience: experience),
              const SizedBox(height: 40),
              const FrameworksSection(),
            ],
          ),
        ),
      ),
    );

    if (!showMenu) return content;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          width: 240,
          child: CareerMenu(
            experiences: experiences,
            activeIndex: _activeStep,
            onSelected: _scrollToStep,
          ),
        ),
        Expanded(child: content),
      ],
    );
  }
}
