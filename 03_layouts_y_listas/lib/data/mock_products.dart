import '../models/product.dart';

const List<Product> mockProducts = [
  Product(
    id: '1',
    name: 'Teclado Mecánico RGB',
    description: 'Teclado mecánico premium con interruptores táctiles silenciosos y retroiluminación RGB personalizable.',
    price: 89.99,
    imageUrl: 'https://images.unsplash.com/photo-1618384887929-16ec33fab9ef?w=500&auto=format&fit=crop&q=60',
    category: 'Accesorios',
    rating: 4.8,
  ),
  Product(
    id: '2',
    name: 'Auriculares Wireless Pro',
    description: 'Auriculares de diadema inalámbricos con cancelación activa de ruido y hasta 30 horas de batería de larga duración.',
    price: 199.99,
    imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500&auto=format&fit=crop&q=60',
    category: 'Audio',
    rating: 4.7,
  ),
  Product(
    id: '3',
    name: 'Smartwatch Sport Fit',
    description: 'Reloj inteligente deportivo con sensor de ritmo cardíaco, GPS integrado, monitoreo del sueño y resistencia al agua.',
    price: 129.50,
    imageUrl: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500&auto=format&fit=crop&q=60',
    category: 'Wearables',
    rating: 4.5,
  ),
  Product(
    id: '4',
    name: 'Ratón Ergonómico Gamer',
    description: 'Ratón de alta precisión con sensor de 16,000 DPI y diseño ergonómico para largas horas de juego u oficina.',
    price: 49.99,
    imageUrl: 'https://images.unsplash.com/photo-1615663245857-ac93bb7c39e7?w=500&auto=format&fit=crop&q=60',
    category: 'Accesorios',
    rating: 4.6,
  ),
  Product(
    id: '5',
    name: 'Altavoz Inteligente Voice',
    description: 'Altavoz inteligente con asistente de voz integrado, sonido envolvente de 360 grados y control de casa domótica.',
    price: 79.99,
    imageUrl: 'https://images.unsplash.com/photo-1589492477829-5e65395b66cc?w=500&auto=format&fit=crop&q=60',
    category: 'Audio',
    rating: 4.4,
  ),
  Product(
    id: '6',
    name: 'Cargador Solar Portátil',
    description: 'Batería externa de 20,000 mAh recargable mediante luz solar. Ideal para viajes, campamentos y exteriores.',
    price: 39.99,
    imageUrl: 'https://images.unsplash.com/photo-1585338107529-13afc5f02586?w=500&auto=format&fit=crop&q=60',
    category: 'Wearables',
    rating: 4.2,
  ),
];

const List<String> categories = ['Todos', 'Accesorios', 'Audio', 'Wearables'];
