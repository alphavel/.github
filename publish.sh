#!/bin/bash
# Script para publicar o README no perfil da organização Alphavel
# Você precisa criar o repositório .github manualmente no GitHub primeiro

set -e

echo "🚀 Preparando publicação do README do perfil Alphavel..."
echo ""

# Verificar se estamos no diretório correto
if [ ! -f "profile/README.md" ]; then
    echo "❌ Erro: Execute este script do diretório /tmp/alphavel-github-profile/"
    exit 1
fi

echo "📋 Estrutura preparada:"
tree -L 2 || ls -R

echo ""
echo "📌 Próximos passos:"
echo ""
echo "1. Criar repositório no GitHub:"
echo "   https://github.com/organizations/alphavel/repositories/new"
echo ""
echo "   - Repository name: .github"
echo "   - Description: Organization profile README"
echo "   - Visibility: Public"
echo "   - ✅ Initialize with README"
echo ""
echo "2. Executar comandos:"
echo ""
echo "   cd /tmp/alphavel-github-profile"
echo "   git init"
echo "   git add ."
echo "   git commit -m 'feat: add organization profile README'"
echo "   git branch -M main"
echo "   git remote add origin https://github.com/alphavel/.github.git"
echo "   git push -u origin main"
echo ""
echo "3. Resultado: README visível em https://github.com/alphavel"
echo ""
echo "✅ Estrutura pronta em: /tmp/alphavel-github-profile/"
