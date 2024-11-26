<template>
    <v-container>
      <v-text-field v-model="search" label="Rechercher des produits" class="mb-4" />
      <v-row>
        <v-col v-for="product in filteredProducts" :key="product.id" cols="12" md="4">
          <v-card @click="selectProduct(product)" class="mx-auto" width="100%" height="200">
            <v-card-title>{{ product.name }}</v-card-title>
            <v-card-subtitle>{{ product.price }}</v-card-subtitle>
          </v-card>
        </v-col>
      </v-row>
    </v-container>
  </template>
  
  <script>
  import { computed, ref } from 'vue';
import { useProductStore } from '../store/productStore';
  
  export default {
    name: 'Products',
    setup() {
      const productStore = useProductStore();
      const search = ref('');
  
      productStore.fetchProducts();
  
      const filteredProducts = computed(() => {
        return productStore.products.filter((product) => {
          return product.name.toLowerCase().includes(search.value.toLowerCase());
        });
      });
  
      const selectProduct = (product) => {
        // Logique pour afficher les détails d'un produit
      };
  
      return {
        search,
        filteredProducts,
        loading: productStore.loading,
        selectProduct,
      };
    },
  };
  </script>
  