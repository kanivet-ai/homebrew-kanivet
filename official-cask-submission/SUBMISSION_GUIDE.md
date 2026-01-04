# Submitting Kanivet to Official Homebrew Cask

## Prerequisites

Before submitting, ensure:
- [ ] App is publicly downloadable (no auth required)
- [ ] App is signed and notarized by Apple
- [ ] Stable versioned release available
- [ ] Direct download URL works

## Steps to Submit

### 1. Fork homebrew-cask

```bash
# Fork https://github.com/Homebrew/homebrew-cask on GitHub
git clone https://github.com/YOUR_USERNAME/homebrew-cask.git
cd homebrew-cask
```

### 2. Create a branch

```bash
git checkout -b add-kanivet
```

### 3. Add the cask file

```bash
cp /path/to/kanivet.rb Casks/k/kanivet.rb
```

### 4. Test locally

```bash
brew install --cask ./Casks/k/kanivet.rb
brew uninstall --cask kanivet
```

### 5. Run style checks

```bash
brew style --fix Casks/k/kanivet.rb
brew audit --cask --online kanivet
```

### 6. Commit and push

```bash
git add Casks/k/kanivet.rb
git commit -m "Add kanivet 0.9.1"
git push origin add-kanivet
```

### 7. Open Pull Request

- Go to https://github.com/Homebrew/homebrew-cask/compare
- Create PR from your fork's `add-kanivet` branch
- Title: `Add kanivet 0.9.1`
- Description template will be provided

## Updating After Acceptance

Once accepted, updates can be submitted via:
1. Manual PR with version bump
2. Using `brew bump-cask-pr kanivet --version X.Y.Z`

## Notes

- Review typically takes 1-7 days
- Maintainers may request changes
- Popularity is a factor but not strict requirement
- Commercial apps are allowed if freely downloadable

