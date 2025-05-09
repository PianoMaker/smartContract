// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

library ArrayLibrary {
    function indexOf(uint[] storage self, uint value) internal view returns (int) {
        for (uint i = 0; i < self.length; ++i){
            if (self[i] == value){
                return int(i);
            }
        }
        return -1;
    }

    function sort(uint[] storage self) internal {
        for (uint i=0; i< self.length; j++) {
            if (self[j] > self [i]) {
                _swap(self, 1);
            }
        }
    }
    function remove(uint[] storage self, uint index) internal {
        require( index < self.length, "Index out of bounds;");
        for (int i = index; i<self.length-1; ++i){
            self[i] = self[i + 1];
        }
        self.pop();
    }

}







