import os
import sys
from argparse import ArgumentParser, Namespace

DEFAULT_FILES: dict[str, str] = {
    "README.md": "# Advent of Code Challenge",
    "input.txt": "",
    "part1.rkt": "#lang racket\n\n;; Solve Part 1\n\n\n",
    "part2.rkt": "#lang racket\n\n;; Solve Part 2\n\n\n",
}

def parse_args() -> Namespace:
    parser = ArgumentParser(description="Advent of Code Challenge Manager")
    parser.add_argument(
        "action", 
        choices=["new", "update"], 
        help="Create a new challenge or update existing challenges"
    )
    return parser.parse_args()

def create_new_challenge() -> None:
    def get_last_challenge_number() -> int:
        challenge_dirs = [
            d for d in os.listdir() 
            if os.path.isdir(d) and d.startswith('day') and d[3:].isdigit()
        ]
        return max((int(d[3:]) for d in challenge_dirs), default=0) + 1

    new_challenge_num = get_last_challenge_number()
    new_challenge_dir = f"day{new_challenge_num}"
    
    try:
        os.makedirs(new_challenge_dir)
        print(f"Created new challenge directory: {new_challenge_dir}")
        
        for filename, content in DEFAULT_FILES.items():
            file_path = os.path.join(new_challenge_dir, filename)
            with open(file_path, 'w') as f:
                f.write(content)
            print(f"  Created {filename}")
    
    except OSError as e:
        print(f"Error creating new challenge: {e}")
        sys.exit(1)

def update_challenges() -> None:
    challenge_dirs = [
        d for d in os.listdir() 
        if os.path.isdir(d) and d.startswith('day') and d[3:].isdigit()
    ]
    
    if not challenge_dirs:
        print("No challenge directories found.")
        return
    
    for challenge_dir in challenge_dirs:
        print(f"Checking {challenge_dir}...")
        
        for filename, default_content in DEFAULT_FILES.items():
            file_path = os.path.join(challenge_dir, filename)
            
            if not os.path.exists(file_path):
                try:
                    with open(file_path, 'w') as f:
                        f.write(default_content)
                    print(f"  Created missing file: {filename}")
                except OSError as e:
                    print(f"  Error creating {filename}: {e}")

def main() -> None:
    try:
        args = parse_args()
        
        if args.action == "new":
            create_new_challenge()
        elif args.action == "update":
            update_challenges()
        else:
            print("Invalid action")
            sys.exit(1)
    
    except Exception as e:
        print(f"An unexpected error occurred: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
