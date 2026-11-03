import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/career_cubit.dart';
import '../../cubits/career_state.dart';
import '../../domain/experience.dart';
import '../widgets/career/career_body.dart';
import '../widgets/career/career_menu.dart';

class CareerPage extends StatelessWidget {
  const CareerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CareerCubit, CareerState>(
      builder: (context, state) => switch (state) {
        CareerLoading() => const Center(child: CircularProgressIndicator()),
        CareerLoaded(:final experiences) => _CareerContent(
          experiences: experiences,
        ),
        CareerError() => const Center(
          child: Text('Impossible de charger le parcours.'),
        ),
      },
    );
  }
}

class _CareerContent extends StatefulWidget {
  const _CareerContent({required this.experiences});

  final List<Experience> experiences;

  @override
  State<_CareerContent> createState() => _CareerContentState();
}

class _CareerContentState extends State<_CareerContent> {
  // Décalage entre le bas de la topbar et l'expérience ciblée après un clic.
  static const _scrollGap = 24.0;
  // Une expérience devient active un peu avant d'atteindre sa position cible.
  static const _activationMargin = 40.0;
  static const _menuMinWidth = 960.0;

  final _scrollController = ScrollController();
  // Une clé par expérience, plus une dernière pour la section Stack technique.
  late final _stepKeys = List.generate(
    widget.experiences.length + 1,
    (_) => GlobalKey(),
  );

  // Isolé dans un notifier : changer d'expérience active ne reconstruit que le menu.
  final _activeStep = ValueNotifier(0);
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
    _activeStep.dispose();
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
    _activeStep.value = active;
  }

  Future<void> _scrollToStep(int index) async {
    final top = _stepTop(index);
    if (top == null) return;

    final request = ++_scrollRequest;
    _activeStep.value = index;
    _isScrollingToStep = true;

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
          child: CareerBody(
            experiences: widget.experiences,
            stepKeys: _stepKeys,
            stackKey: _stepKeys.last,
            showStackShortcut: !showMenu,
            onScrollTo: _scrollToStep,
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
          child: ValueListenableBuilder(
            valueListenable: _activeStep,
            builder: (context, activeStep, _) => CareerMenu(
              experiences: widget.experiences,
              activeIndex: activeStep,
              onSelected: _scrollToStep,
            ),
          ),
        ),
        Expanded(child: content),
      ],
    );
  }
}
