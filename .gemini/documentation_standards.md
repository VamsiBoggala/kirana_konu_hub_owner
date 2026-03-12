# Documentation Standard & Best Practices

## Purpose
This document outlines the documentation standards for the Kirana Konu Hub Owner application. Every feature should have living documentation that stays current with code changes.

## Documentation Structure

### Project Level
```
project_root/
├── README.md                    # Project overview
├── .gemini/                     # Development session summaries
│   ├── *.md                     # Refactoring summaries, session notes
└── lib/
    ├── features/
    │   ├── README.md            # Features directory overview
    │   ├── auth/
    │   │   └── README.md        # Auth feature documentation
    │   ├── registration/
    │   │   └── README.md        # Registration feature documentation
    │   └── new_feature/
    │       └── README.md        # New feature documentation (REQUIRED)
    └── core/
        └── README.md            # Core utilities documentation (TODO)
```

## Feature README Template

Every new feature MUST have a README.md in its root directory with the following sections:

### Required Sections

#### 1. Overview
- Brief description of the feature
- Purpose and goals
- Target users

#### 2. Architecture
- State management approach (BLoC, etc.)
- Design patterns used
- Key architectural decisions

#### 3. Directory Structure
```
feature_name/
├── data/
├── domain/
└── presentation/
```

#### 4. Features
- ✅ Implemented features
- 🚧 TODO/Planned features

#### 5. User Flows
- Step-by-step user journeys
- Flow diagrams (text-based or Markdown)

#### 6. BLoC Implementation
- **Events table:** Name, description, parameters
- **States table:** Name, description, data
- Event handlers overview

#### 7. Data Models
- Model classes
- Field descriptions
- Validation rules

#### 8. Screens
- Screen-by-screen breakdown
- Features per screen
- BLoC integration details

#### 9. Routes
- Available routes
- Navigation patterns

#### 10. Dependencies
- External packages
- Internal dependencies
- Core dependencies

#### 11. Integration
- How to use the feature
- Code examples
- Provider setup

#### 12. Testing
- Test cases
- Manual testing instructions
- Coverage goals

#### 13. Changelog
- Version history
- What changed when
- Breaking changes

#### 14. Related Features
- Dependencies on other features
- Features that depend on this

#### 15. API Integration (if applicable)
- Endpoints needed
- Request/response formats
- Authentication

#### 16. Notes & Warnings
- Important considerations
- Security notes
- Performance notes

## When to Update Documentation

### ✅ ALWAYS Update README When:

1. **Adding a new screen**
   - Add to screens section
   - Update flow diagrams
   - Document routing

2. **Adding events or states**
   - Update BLoC tables
   - Document new flows
   - Add examples

3. **Changing business logic**
   - Update architecture section
   - Document decision rationale
   - Update flows

4. **Adding dependencies**
   - List in dependencies section
   - Explain why needed
   - Version constraints

5. **Refactoring**
   - Update affected sections
   - Note what changed
   - Update examples

6. **Breaking changes**
   - Highlight in changelog
   - Update migration guide
   - Version bump

### Documentation-First Development

**Before implementing a feature:**
1. Create README.md
2. Document intended architecture
3. List planned screens
4. Define events and states
5. Outline flows

**Benefits:**
- Clear roadmap
- Better planning
- Team alignment
- Easier reviews

## Writing Style

### Be Clear and Concise
✅ Good: "Phone authentication with OTP verification"
❌ Bad: "This complex authentication system uses various modern techniques..."

### Use Examples
```dart
// ✅ Good: Show actual code
context.read<AuthBloc>().add(LoginEvent(phone: '+919876543210'));

// ❌ Bad: Just describe
// Send login event with phone number
```

### Use Tables for Structured Data
✅ Good:
| Event | Parameters | Description |
|-------|-----------|-------------|
| LoginEvent | phone | Initiates login |

❌ Bad:
LoginEvent takes a phone parameter and initiates the login process.

### Use Checklists for Status
- ✅ Implemented
- 🚧 In Progress
- ❌ Blocked
- [ ] TODO

### Use Visual Separators
```
Step 1
  ↓
Step 2
  ↓
Step 3
```

## Code Documentation

### Inline Comments
```dart
// ✅ Good: Explain WHY
// Check registration status because new users need onboarding
if (!user.hasCompletedRegistration) {
  navigateToRegistration();
}

// ❌ Bad: Explain WHAT (code is self-evident)
// Check if user has not completed registration
if (!user.hasCompletedRegistration) {
  navigateToRegistration();
}
```

### Class/Function Documentation
```dart
/// ✅ Good: Clear, useful documentation
/// Authenticates user via phone number and OTP.
/// 
/// This bloc handles the complete phone auth flow:
/// 1. Send OTP to phone
/// 2. Verify OTP code
/// 3. Create/retrieve user session
/// 
/// Important: Currently uses mock implementation.
/// TODO: Integrate with Firebase Phone Auth
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // ...
}

/// ❌ Bad: Obvious, no added value
/// Auth bloc class
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // ...
}
```

### TODO Comments
```dart
// TODO: Integrate Firebase Phone Auth (Issue #123)
// TODO(yourname): Optimize this query
// FIXME: Race condition when multiple uploads
// HACK: Temporary workaround for platform bug
```

## Review Checklist

Before marking a feature as complete, ensure:

- [ ] README.md exists in feature directory
- [ ] All required sections present
- [ ] BLoC events and states documented
- [ ] User flows documented
- [ ] Code examples included
- [ ] Dependencies listed
- [ ] Testing instructions clear
- [ ] Changelog updated
- [ ] No Lorem Ipsum or placeholder text
- [ ] Links work and point to correct files
- [ ] Code snippets are accurate
- [ ] Formatting is consistent

## Maintenance

### Weekly:
- Review open TODOs
- Update status badges
- Check for outdated information

### Per Release:
- Update changelog
- Version documentation
- Archive old information

### Per Quarter:
- Audit all documentation
- Remove obsolete content
- Reorganize if needed

## Tools & Automation

### Recommended Tools:
- **Markdown Preview:** VS Code extension
- **Grammarly:** For spelling/grammar
- **Draw.io:** For complex diagrams
- **Mermaid:** For flow diagrams in Markdown

### Auto-generation (TODO):
- Generate BLoC tables from code
- Extract route constants automatically
- Generate dependency graphs
- API documentation from code

## Examples of Good Documentation

### Within This Project:
✅ `/lib/features/auth/README.md` - Complete auth feature docs
✅ `/lib/features/registration/README.md` - Complete registration docs
✅ `/lib/features/README.md` - Features overview

### Look At These When Stuck:
- Existing feature READMEs
- `.gemini/*.md` summaries
- This document!

## Anti-Patterns to Avoid

### ❌ Don't:
1. Copy-paste without updating
2. Leave TODOs forever
3. Document implementation details that change often
4. Write a novel (be concise)
5. Skip examples
6. Forget to update after changes
7. Use vague language
8. Duplicate information across files

### ✅ Do:
1. Write for your future self
2. Keep it DRY (link to other docs)
3. Update as you code
4. Use clear, simple language
5. Include practical examples
6. Focus on WHY, not just WHAT
7. Use visual aids (tables, flows)
8. Link related documentation

## Documentation as Code

Treat documentation like code:
- **Review it:** Documentation PRs required
- **Version it:** Commit with code changes
- **Test it:** Links work, examples compile
- **Refactor it:** Improve clarity over time
- **Own it:** Documentation is not optional

## Questions to Ask Yourself

Before submitting:
1. Can a new developer understand this feature from the README?
2. Would I understand this in 6 months?
3. Are there enough examples?
4. Is anything missing?
5. Is anything outdated?
6. Are the flows clear?
7. Would this help during debugging?

## Remember

> "Code tells you HOW, documentation tells you WHY."

> "The best documentation is the one that exists and is current."

> "If it's not documented, it doesn't exist."

## Need Help?

- Check existing READMEs for examples
- Ask team members for review
- Use this document as a checklist
- Start small, improve incrementally

---

**Last Updated:** 2025-12-16  
**Author:** Development Team  
**Status:** Living Document
