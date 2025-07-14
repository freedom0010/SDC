// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract DataLocationFix {
    // ✅ 示例 1：对数组参数使用 calldata（推荐用于 external + 只读）
    function processArray(uint[] calldata arr) external pure returns (uint) {
        return arr[0];
    }

    // ✅ 示例 2：自定义结构体
    struct MyStruct {
        uint id;
        string name;
    }

    // ✅ 示例 3：结构体参数使用 calldata（只能在 external 函数中使用）
    function processStruct(MyStruct calldata data) external pure returns (uint) {
        return data.id;
    }

    // ✅ 示例 4：基础类型不需要 data location
    // ✅ string 属于动态类型，必须使用 memory
   function validBaseType(uint, string memory text) public pure returns (string memory) {
    return text;
}


    // ✅ 示例 5：memory 结构体只能用于 public/internal
    function useStructMemory(MyStruct memory data) public pure returns (string memory) {
        return data.name;
    }
}
