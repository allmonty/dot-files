# Git configs and commands

## Config ssh

Create ssh key with

```sh
ssh-keygen -t ed25519 -C "your_email@youremail.com"
```

Start ssh-agent

```sh
eval `ssh-agent -s`
```

Clear cached ssh key if needed

```sh
ssh-add -D
```

Add key

```sh
ssh-add ~/.ssh/created_key
```

Check

```sh
ssh-add -l
```

After that config the `~/.ssh/config` file

Then, go to github and gitlab and config the ssh key.
To see the key `cat ~/.ssh/key_name.pub`

## Better experience with Git

- Good commands and how to configure them [here](https://github.com/allmonty/inutils/blob/master/git/good-commands.md)
- Auto-completition in bash
  - [Configure it](https://git-scm.com/book/en/v1/Git-Basics-Tips-and-Tricks)
  - [Just install](https://github.com/bobthecow/git-flow-completion/wiki/Install-Bash-git-completion)
- Pretty Diff
  - Use [diff-so-fancy](https://github.com/so-fancy/diff-so-fancy)
  - Execute the ```pretty-diff.sh``` to intall it