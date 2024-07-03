import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Product } from 'src/entities/product.entity';
import { Repository } from 'typeorm';

@Injectable()
export class ProductService {
  constructor(
    @InjectRepository(Product)
    private productRepository: Repository<Product>,
  ) {}

  findAll(): Promise<Product[]> {
    return this.productRepository.find();
  }

  findOne(id: number): Promise<Product> {
    return this.productRepository.findOneBy({ id });
  }

  async create(product: Product): Promise<Product> {
    return this.productRepository.save(product);
  }

  async update(id: number, product: Product): Promise<void> {
    await this.productRepository.update(id, product);
  }

  async remove(id: number): Promise<void> {
    await this.productRepository.delete(id);
  }
}
