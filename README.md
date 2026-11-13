# korean-humanizer-plus

AI가 쓴 티가 나는 한국어 글을 사람이 쓴 글처럼 윤문하는 에이전트 스킬입니다. Claude Code, Codex, claude.ai에서 씁니다.

[daleseo/korean-skills](https://github.com/daleseo/korean-skills)의 `humanizer`와 [nomadamas/k-skill](https://github.com/NomaDamas/k-skill)의 `korean-humanizer`를 하나로 합쳤습니다.

- **표현 흔적**: 번역체(~에 대해·~를 통해·가지다·되어지다), AI 상투어, 과장된 의의, 결말 공식, 3의 법칙, 챗봇 말투, 줄표·이모지·볼드 장식
- **통계 신호**: 쉼표 비율, 연결어미 뒤 쉼표, 띄어쓰기 균일성, 명사 과다 ([KatFishNet](https://arxiv.org/abs/2503.00032))

흔적은 S1/S2/S3 심각도로 나눕니다. 수치, 고유명사, 인용은 그대로 두고, 변경률이 30%를 넘으면 경고하고 50%를 넘으면 멈춥니다. 진단만 하기, 목표 글자수 맞추기, 말투 샘플 반영도 됩니다.

## 설치

```bash
# Claude Code와 Codex에 전역 설치
npx skills add kimtj12/korean-humanizer-plus -g -a claude-code codex -y
```

## 사용

자동으로 호출되지 않고, 직접 부를 때만 실행됩니다.

| 도구 | 호출 |
|---|---|
| Claude Code | `/korean-humanizer-plus` + 글 붙여넣기 |
| Codex | `$korean-humanizer-plus` + 글 붙여넣기 |

```
/korean-humanizer-plus 이 글 AI 티 안 나게 다듬어줘: (본문)
/korean-humanizer-plus 진단만 해줘: (본문)
/korean-humanizer-plus 1000자로 맞춰서: (본문)
```

호출 제한은 Claude Code에서는 `SKILL.md`의 `disable-model-invocation: true`가, Codex에서는 `agents/openai.yaml`의 `allow_implicit_invocation: false`가 맡습니다.

## claude.ai

claude.ai는 `disable-model-invocation` 키를 거부하므로, 이 키를 뺀 zip을 따로 만들어 올립니다. claude.ai에서는 슬래시 전용으로 제한할 수 없고, 요청 내용에 따라 자동으로 호출됩니다.

```bash
./scripts/build-claude-ai-zip.sh   # dist/korean-humanizer-plus.zip 생성
```

Settings → Capabilities → Skills → Upload skill에서 올립니다.

## 구조

```
skills/korean-humanizer-plus/
├── SKILL.md                         절차·철칙·자가검증·등급·출력 형식
├── agents/openai.yaml               Codex 호출 정책
├── references/
│   ├── patterns-expression.md       표현 흔적 A~K
│   ├── patterns-statistical.md      통계 신호 P·S·N
│   └── voice-and-length.md          글자수·말투·목소리 (선택 기능)
├── examples/                        칼럼, 보고서 예시
└── SOURCES.md                       원본 커밋, 두 원본의 충돌을 정리한 기준
```

## 라이선스

MIT. 원본 두 프로젝트(모두 MIT)의 저작권 고지는 [LICENSE](LICENSE)에 있습니다.
