# Architecture Rules — Sleepify

## Feature-First MVVM + Repository + Riverpod

Every feature follows this structure:

```
features/<feature>/
├── data/
│   ├── data_sources/    # Remote/local data access
│   ├── repositories/    # Repository implementation (suffix: Impl)
│   ├── dto/             # Data Transfer Objects (optional)
│   └── mappers/         # DTO ↔ Domain model mapping (optional)
├── domain/
│   ├── models/          # @freezed domain models
│   ├── repositories/    # Abstract repository interface
│   └── services/        # ONLY when combining 2+ repos or complex logic
└── presentation/
    ├── providers/       # @riverpod ViewModels / Notifiers
    ├── screens/         # Full-page widgets (suffix: Screen)
    └── widgets/         # Reusable UI components
```

## Dependency Flow

```
UI → ViewModel → Repository → DataSource         (standard)
UI → ViewModel → Service → Repository → DataSource (complex only)
```

## Hard Rules

- **NEVER** import `data/` from `domain/`
- **NEVER** import `presentation/` from `data/` or `domain/`
- Cross-feature imports go through `shared/` or the feature's `domain/` layer only
- Global features (e.g., `player`): other features reference `domain/models/` and `presentation/providers/`, NOT `data/`

## Service Layer Decision

- ✅ ADD: combining 2+ repositories, complex business logic, logic reused across ViewModels
- ❌ SKIP: ViewModel simply calls a single repository method
- When in doubt → start without it, add when ViewModel grows complex

## Shared Code

```
lib/
├── core/              # App-wide utilities, constants, theme
│   ├── theme/         # AppTheme, colors, text styles
│   ├── constants/     # App constants, asset paths
│   ├── utils/         # Utility functions
│   └── router/        # go_router configuration
├── shared/            # Cross-feature shared code
│   ├── models/        # Shared domain models
│   ├── providers/     # Shared providers
│   └── widgets/       # Shared UI components
└── features/          # Feature modules
```
