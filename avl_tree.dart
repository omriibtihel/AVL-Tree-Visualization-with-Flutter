class Node {
  int key;
  int height;
  Node? left;
  Node? right;

  Node(this.key) : height = 1;
}

class AVLTree {
  Node? root;

  int height(Node? node) {
  return node?.height ?? 0;
  }

  int max(int a, int b) {
  return (a > b) ? a : b;
  }

  Node rightRotate(Node y) {
  Node x = y.left!;
  Node? t = x.right;

  x.right = y;
  y.left = t;

  y.height = max(height(y.left), height(y.right)) + 1;
  x.height = max(height(x.left), height(x.right)) + 1;

  return x;
  }

  Node leftRotate(Node x) {
  Node y = x.right!;
  Node? t = y.left;

  y.left = x;
  x.right = t;

  x.height = max(height(x.left), height(x.right)) + 1;
  y.height = max(height(y.left), height(y.right)) + 1;

  return y;
  }

  int getBalance(Node? node) {
  if (node == null) return 0;
  return height(node.left) - height(node.right);
  }

  Node insertNode(Node? node, int key) {
  if (node == null) return Node(key);

  if (key < node.key) {
  node.left = insertNode(node.left, key);
  } else if (key > node.key) {
  node.right = insertNode(node.right, key);
  } else {
  return node;
  }

  node.height = 1 + max(height(node.left), height(node.right));

  int balance = getBalance(node);

  if (balance > 1 && key < node.left!.key) {
  return rightRotate(node);
  }

  if (balance < -1 && key > node.right!.key) {
  return leftRotate(node);
  }

  if (balance > 1 && key > node.left!.key) {
  node.left = leftRotate(node.left!);
  return rightRotate(node);
  }

  if (balance < -1 && key < node.right!.key) {
  node.right = rightRotate(node.right!);
  return leftRotate(node);
  }

  return node;
  }

  Node? minValueNode(Node node) {
  Node current = node;

  while (current.left != null) {
  current = current.left!;
  }

  return current;
  }

  Node? deleteNode(Node? root, int key) {
  if (root == null) return root;

  if (key < root.key) {
  root.left = deleteNode(root.left, key);
  } else if (key > root.key) {
  root.right = deleteNode(root.right, key);
  } else {
  if (root.left == null || root.right == null) {
  Node? temp = root.left ?? root.right;

  if (temp == null) {
  temp = root;
  root = null;
  } else {
  root = temp;
  }
  } else {
  Node temp = minValueNode(root.right!)!;
  root.key = temp.key;
  root.right = deleteNode(root.right, temp.key);
  }
  }

  if (root == null) return root;

  root.height = max(height(root.left), height(root.right)) + 1;

  int balance = getBalance(root);

  if (balance > 1 && getBalance(root.left) >= 0) {
  return rightRotate(root);
  }

  if (balance > 1 && getBalance(root.left) < 0) {
  root.left = leftRotate(root.left!);
  return rightRotate(root);
  }

  if (balance < -1 && getBalance(root.right) <= 0) {
  return leftRotate(root);
  }

  if (balance < -1 && getBalance(root.right) > 0) {
  root.right = rightRotate(root.right!);
  return leftRotate(root);
  }

  return root;
  }

  Node? search(Node? node, int key) {
  if (node == null || node.key == key) {
  return node;
  }

  if (node.key < key) {
  return search(node.right, key);
  }

  return search(node.left, key);
  }

}
