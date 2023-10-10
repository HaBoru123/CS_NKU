#include <stdio.h>

char* encryptDecrypt(char *message, char key) {
    // 获取消息的长度
    int len = 0;
    while (message[len] != '\0') {
        len++;
    }

    // 对消息进行异或加密或解密
    for (int i = 0; i < len; i++) {
        message[i] = message[i] ^ key;
    }

    return message;
}

int main() {
    char message[100];
    char key;

    printf("Enter message: ");
    scanf("%99[^\n]", message); // 读取包含空格的整行输入
    getchar(); // 清除输入缓冲区中的换行符

    printf("Enter encryption key: ");
    scanf("%c", &key);

    char* encryptedMessage = encryptDecrypt(message, key);
    printf("Encrypted message: %s\n", encryptedMessage);

    return 0;
}

