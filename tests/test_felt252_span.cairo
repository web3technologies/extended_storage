use starknet::ContractAddress;
use snforge_std::{declare, ContractClassTrait};

use starknet_extended_storage::example_contract::IExampleContractSafeDispatcher;
use starknet_extended_storage::example_contract::IExampleContractSafeDispatcherTrait;
use starknet_extended_storage::example_contract::IExampleContractDispatcher;
use starknet_extended_storage::example_contract::IExampleContractDispatcherTrait;


fn deploy_contract(name: felt252) -> ContractAddress {
    let contract = declare(name);
    contract.deploy(@ArrayTrait::new()).unwrap()
}

#[test]
fn test_span_is_in_storage() {
    let contract_address = deploy_contract('ExampleContract');
    let dispatcher = IExampleContractDispatcher { contract_address };

    let example_felt_span = array!['test1', 'test2','test3'].span();

    dispatcher.add_span(example_felt_span);
    let contract_storage_span: Span<felt252> = dispatcher.get_span();

    assert(example_felt_span == contract_storage_span, 'Span are not the same');

    let span_length:u32 = example_felt_span.len();
    let mut current_count:u32 = 0;

    // iterate through and make the test
    loop {
        if current_count < span_length{
            assert(
                *example_felt_span.at(current_count) == *contract_storage_span.at(current_count),
                'item is not the same'
            );
            current_count += 1;
        } else{
            break();
        }
    }
}