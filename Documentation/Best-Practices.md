# 📚 Best Practices Guide - HitBox Team

## 📝 Summary
1. [Symfony 7.2](#symfony-standards)
2. [Vue.js](#vue-standards)
3. [Workflow & Quality](#workflow--quality)

## 🎯 Symfony Standards (7.2)

### Architecture
- Controller → Service → Repository
- Strict types required (`declare(strict_types=1)`)
- `final` classes by default
- PHP 8 attributes for annotations

### Example Pattern
```php
#[Route('/api/games')]
final class GameController
{
    public function __construct(
        private readonly GameService $gameService
    ) {}

    #[Route('', methods: ['POST'])]
    public function create(#[MapRequestPayload] GameDTO $dto): JsonResponse
    {
        return new JsonResponse(
            $this->gameService->create($dto),
            Response::HTTP_CREATED
        );
    }
}
```

### Key Points
- DTOs for all requests/responses
- Systematic validation via attributes
- Dependency injection
- Strict typing everywhere
- Value Objects for business logic

## 🎯 Vue Standards

### Structure
```
src/
├── components/
│   ├── common/      # Shared components
│   └── features/    # Business components
├── composables/     # Shared logic
├── stores/         # State (Pinia)
└── views/          # Pages
```

### Example Pattern
```vue
<script setup lang="ts">
import { ref } from 'vue'
import type { Game } from '@/types'

interface Props {
  gameId: string
}
defineProps<Props>()
const emit = defineEmits<{
  (e: 'update', game: Game): void
}>()

const game = ref<Game | null>(null)
</script>

<template>
  <div class="game-detail">
    <h1>{{ game?.title }}</h1>
  </div>
</template>
```

### Key Points
- TypeScript mandatory
- `<script setup>` systematic
- Pinia for global state
- Atomic components
- Vitest testing

## 🎯 Workflow & Quality

### Git Flow
- `main`: production only
- `dev`: ongoing development
- `hotfix/*`: emergencies (from main)
- `feature/*`, `fix/*`, `refacto/*`: new features, fixes, and refactoring (from dev)

### Commit Standards
Format: `type(scope): short description`

Types:
- `feat`: new feature
- `fix`: bug fix
- `refactor`: code refactoring
- `style`: formatting, semicolons, etc.
- `test`: adding/updating tests
- `docs`: documentation
- `chore`: maintenance

Examples:
```bash
feat(auth): add Google login
fix(matchmaking): fix MMR calculation
refactor(api): optimize ranking queries
test(user): add registration tests
```

Rules:
- Description in English
- Use imperative mood
- Max 50 characters
- No capital at start
- No period at end

### Security
- DTO + Validator validation
- JWT + Refresh Token
- Strict CORS
- Monolog logging
- No secrets in Git

### Testing
- PHPUnit (Symfony)
- Vitest (Vue)
- Unit tests required
- 80% coverage minimum

### Documentation
- PHPDoc public methods
- Updated README
- OpenAPI
- Changelog 