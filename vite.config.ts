import { defineConfig } from 'vite';

if (!process.env.START_URL) {
    console.error('error: you need to define an environment variable called START_URL, which defines the redirection to be executed as soon as the application starts up');
    process.exit(1);
}

export default defineConfig({
  root: './src',
  build: {
    outDir: '../dist',
    minify: false,
    emptyOutDir: true,
  },
  define: {
    'process.env.START_URL': JSON.stringify(process.env.START_URL)
  }
});
