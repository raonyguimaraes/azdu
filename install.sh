echo "Installing Azdu"
#curl -sf -L https://github.com/raonyguimaraes/azdu/releases/download/0.1/azdu > /usr/local/bin/azdu
#https://stackoverflow.com/questions/2500436/how-does-cat-eof-work-in-bash 
#https://superuser.com/questions/553932/how-to-check-if-i-have-sudo-access

prompt=$(sudo -nv 2>&1)
if [ $? -eq 0 ]; then
  sudo cat << EOF > /usr/local/bin/azdu
    #!/usr/bin/env python3
    
    import argparse
    import os
    
    parser = argparse.ArgumentParser()
    parser.add_argument("path")
    args = parser.parse_args()
    
    def azdu(start_path = '.'):
        total_size = 0
        for dirpath, dirnames, filenames in os.walk(start_path):
            for f in filenames:
                fp = os.path.join(dirpath, f)
                # skip if it is symbolic link
                if not os.path.islink(fp):
                    total_size += os.path.getsize(fp)
        return total_size
    
    def bytes_to_human_readable(num, suffix='B'):
        for unit in ['', 'K', 'M', 'G', 'T', 'P', 'E', 'Z']:
            if abs(num) < 1024.0:
                return f"{num:3.1f}{unit}{suffix}"
            num /= 1024.0
        return f"{num:.1f}Yi{suffix}"
    
    if __name__ == '__main__':
        print(bytes_to_human_readable(azdu(args.path)))
    EOF
    sudo chmod +x /usr/local/bin/azdu

elif echo $prompt | grep -q '^sudo:'; then
  sudo cat << EOF > /usr/local/bin/azdu
    #!/usr/bin/env python3
    
    import argparse
    import os
    
    parser = argparse.ArgumentParser()
    parser.add_argument("path")
    args = parser.parse_args()
    
    def azdu(start_path = '.'):
        total_size = 0
        for dirpath, dirnames, filenames in os.walk(start_path):
            for f in filenames:
                fp = os.path.join(dirpath, f)
                # skip if it is symbolic link
                if not os.path.islink(fp):
                    total_size += os.path.getsize(fp)
        return total_size
    
    def bytes_to_human_readable(num, suffix='B'):
        for unit in ['', 'K', 'M', 'G', 'T', 'P', 'E', 'Z']:
            if abs(num) < 1024.0:
                return f"{num:3.1f}{unit}{suffix}"
            num /= 1024.0
        return f"{num:.1f}Yi{suffix}"
    
    if __name__ == '__main__':
        print(bytes_to_human_readable(azdu(args.path)))
    EOF
    sudo chmod +x /usr/local/bin/azdu  
else
  cat << EOF > /usr/local/bin/azdu
#!/usr/bin/env python3

import argparse
import os

parser = argparse.ArgumentParser()
parser.add_argument("path")
args = parser.parse_args()

def azdu(start_path = '.'):
    total_size = 0
    for dirpath, dirnames, filenames in os.walk(start_path):
        for f in filenames:
            fp = os.path.join(dirpath, f)
            # skip if it is symbolic link
            if not os.path.islink(fp):
                total_size += os.path.getsize(fp)
    return total_size

def bytes_to_human_readable(num, suffix='B'):
    for unit in ['', 'K', 'M', 'G', 'T', 'P', 'E', 'Z']:
        if abs(num) < 1024.0:
            return f"{num:3.1f}{unit}{suffix}"
        num /= 1024.0
    return f"{num:.1f}Yi{suffix}"

if __name__ == '__main__':
    print(bytes_to_human_readable(azdu(args.path)))
EOF
    chmod +x /usr/local/bin/azdu

fi




