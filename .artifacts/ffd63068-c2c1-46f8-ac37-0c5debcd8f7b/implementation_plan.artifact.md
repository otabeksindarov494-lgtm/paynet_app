# Clean Architecture Refactoring & Code Modularization

Refactor the Flutter project to follow Clean Architecture principles and break down large classes/widgets into smaller, modular, single-responsibility classes, ensuring 100% preservation of existing functionality and behavior.

## User Review Required

> [!IMPORTANT]
> - **Architecture Structure**: We will organize the project into `domain`, `data`, and `presentation` layers.
> - **State Management / Dependency Injection**: We will structure business logic cleanly using Use Cases and Repositories, backed by lightweight ViewModels / State Notifiers (or clean separation of concerns) without introducing heavy boilerplate that alters app behavior.
> - **File Splitting**: Large files like `change_screen.dart` (~690 lines), `request_money_page.dart` (~683 lines), and `request_check_page.dart` (~512 lines) will be broken down into modular widgets and helper classes.

## Proposed Changes

### Domain Layer (`lib/domain/`)
- **Entities**:
  - `lib/domain/entities/request_entity.dart`: Core domain model for requests.
- **Repositories (Interfaces)**:
  - `lib/domain/repositories/history_repository.dart`: Abstract repository definition for saving, loading, and updating request history.
- **Use Cases**:
  - `lib/domain/usecases/get_history_usecase.dart`
  - `lib/domain/usecases/save_history_usecase.dart`
  - `lib/domain/usecases/cancel_request_usecase.dart`

### Data Layer (`lib/data/`)
- **Models (DTOs)**:
  - `lib/data/models/request_model.dart`: JSON serialization / mapping to/from `RequestEntity`.
- **Data Sources**:
  - `lib/data/datasources/history_local_datasource.dart`: SharedPreferences local storage implementation.
- **Repositories (Implementation)**:
  - `lib/data/repositories/history_repository_impl.dart`: Implementation of `HistoryRepository`.

### Presentation Layer (`lib/presentation/` or modularized features)
- **State / ViewModels**:
  - `lib/presentation/history/history_viewmodel.dart` / state management for history and requests.
- **Pages & Modularized Widgets**:
  - **History Feature**: Refactor `history_page.dart`, `request_check_page.dart`, `change_screen.dart`, `final_page.dart`, breaking down large files into smaller component widgets under `lib/presentation/history/widgets/`.
  - **Transfer / Request Money Feature**: Refactor `request_money_page.dart`, `Transfer_page.dart`, `transfer_grid.dart`, etc., into modular components under `lib/presentation/transfer/widgets/`.
  - **Common Widgets & Theme**: Clean up and organize under `lib/presentation/common/` or `lib/core/`.

## Verification Plan

### Automated Tests
- Run `flutter test` (if unit tests exist or can be added).
- Build the app with `flutter build` or `flutter analyze` to ensure zero compilation errors or linter warnings.

### Manual Verification
- Verify app startup, navigation between tabs, history loading, request creation, status updates (cancelling requests), and all UI interactions match original behavior.
