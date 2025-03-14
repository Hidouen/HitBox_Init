# 📚 Best practices guide 

## 📝 Summary
1. [Workflow & Quality](#workflow--quality)
2. [Symfony 7.2](#symfony-standards)
3. [Vue.js](#vue-standards)

## 🎯 Workflow & quality

### Git flow
- `main`: production only
- `dev`: ongoing development
- `hotfix/*`: emergencies (from main)
- `feat/*` : new features, or other types (from dev)

### Commit standards
Format: `type(scope): short description`

Types:
- `feat`: new feature
- `fix`: bug fix
- `refacto`: code refactoring
- `style`: formatting, semicolons, etc.
- `test`: adding/updating tests
- `docs`: documentation

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

## 🎯 Symfony standards (7.2)

### Architecture
- Controller -> Service -> Repository
- Strict types required (`declare(strict_types=1)`)
- PHP 8 attributes

### Example pattern
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

### Key points
- DTOs for all requests/responses
- Systematic validation via attributes
- Dependency injection (autowiring)
- Strict typing everywhere
- Value Objects for business logic

## 🎯 Vue standards

### Structure
```
src/
├── components/
│   ├── common/     # Shared components
│   └── features/   # Business components
├── composables/    # Shared logic
├── stores/         # State (Pinia)
└── views/          # Pages
```

### Example pattern
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

### Key points
- TypeScript mandatory
- `<script setup>` systematic
- Pinia for global state
- Atomic components
- Vitest testing