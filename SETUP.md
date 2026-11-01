# GitHub setup (about 15 minutes)

1. Replace the placeholder everywhere:
   `grep -rl menakamaheswari1234-cpu . | xargs sed -i 's/menakamaheswari1234-cpu/<your-github-username>/g'`
   (on macOS use `sed -i ''`)

2. Profile repo: create a PUBLIC repo named exactly your username and copy `profile/README.md` into it as `README.md`.

3. For each project folder, create a public repo with the same name, then:
   ```
   cd <folder> && git init -b main && git add . && git commit -m "Initial commit"
   git remote add origin https://github.com/<username>/<folder>.git && git push -u origin main
   ```

4. Pin the 4 project repos on your profile (Customize your pins). Add a one-line description and topics (terraform, eks, jenkins, argocd, devsecops) to each repo.

5. Before pushing, check that there are no secrets, account IDs or client names anywhere.

## Resume line
GitHub: github.com/<username> (reference implementations: Terraform EKS, Jenkins DevSecOps pipeline, ArgoCD GitOps, Python tooling)
