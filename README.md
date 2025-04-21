## commit-suggestion

Generates short and semantically correct commit messages based on your code diff, using Anthropic's API.

## 🚀 Installation

1. Download the script to your local user directory:

   ```bash
   mkdir -p ~/.local/bin && \
   curl -L https://raw.githubusercontent.com/jesherdevsk8/commit-suggestion/master/commit_suggestion.rb -o ~/.local/bin/commit && \
   chmod +x ~/.local/bin/commit
   ```

2. Add `~/.local/bin` to your `PATH` (if it's not already):

   In your `~/.bashrc`:

   ```bash
   echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
   ```

   Or in your `~/.zshrc` (if you're using Zsh):

   ```bash
   echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
   ```

   Then reload your shell:

   ```bash
   source ~/.bashrc    # or
   source ~/.zshrc
   ```

3. **Create Group for Access Control (Optional)**

   To secure your API key, we can store it in a central file, accessible only by a specific group.
   
   - Create a group:
   
   ```bash
   sudo groupadd commitusers
   ```
   
   - Add your user to the group:
   
   ```bash
   sudo usermod -aG commitusers $USER
   ```
   
   > ⚠️ You need to log out and log back in for the group change to take effect.

4. **Set the API Key in a Centralized File**

   Create the file `/etc/commit-suggestion.env` to store your Anthropic API key securely:
   
   ```bash
   sudo tee /etc/commit-suggestion.env > /dev/null <<EOF
   export ANTHROPIC_API_KEY="sk-ant-api-..."
   EOF
   ```
   
   Make sure only the root user and the `commitusers` group can read the file:
   
   ```bash
   sudo chown root:commitusers /etc/commit-suggestion.env
   sudo chmod 640 /etc/commit-suggestion.env
   ```

5. **Load the Environment Variable**

   add the following to load the API key:
   In your `~/.bashrc`
   
   ```bash
   echo '[ -r /etc/commit-suggestion.env ] && source /etc/commit-suggestion.env' >> ~/.bashrc
   ```

   Or in your `~/.zshrc`

   ```bash
   echo '[ -r /etc/commit-suggestion.env ] && source /etc/commit-suggestion.env' >> ~/.zshrc
   ```
   
   Then, reload your shell:
   
   ```bash
   source ~/.bashrc    # or
   source ~/.zshrc
   ```

   > ⚠️ You need to log out and log back in for the group change to take effect.

## 🧪 Usage

Inside any Git repository directory, run:

```bash
commit
```

## ✅ Example

```bash
cd ~/my-project
git add .
commit
# => Suggests a commit message based on your current diff
```
