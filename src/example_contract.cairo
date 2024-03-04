#[starknet::interface]
pub trait IExampleContract<TContractState> {
    fn add_span(ref self: TContractState, span_data: Span<felt252>);
    fn get_span(self: @TContractState) -> Span<felt252>;
}

#[starknet::contract]
mod ExampleContract {

    use extended_storage::storage::felt252_span::StoreSpanFelt252;

    #[storage]
    struct Storage {
        example_span: Span<felt252> 
    }

    #[abi(embed_v0)]
    impl ExampleContractImpl of super::IExampleContract<ContractState> {
        fn add_span(ref self: ContractState, span_data: Span<felt252>) {
            self.example_span.write(span_data);
        }

        fn get_span(self: @ContractState) -> Span<felt252> {
            self.example_span.read()
        }
    }
}