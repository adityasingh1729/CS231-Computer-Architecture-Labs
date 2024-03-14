#include <algorithm>
#include <cassert>
#include <map>
#include <vector>
#include <cstdlib>
#include <ctime>

#include "cache.h"

namespace {
    std::map<CACHE*, std::vector<bool>> binary_order; // Add a map to keep track of binary insertion order
}

void CACHE::initialize_replacement() { 
    ::binary_order[this] = std::vector<bool>(NUM_SET * NUM_WAY, false); // Initialize the binary insertion order vector
    std::srand(std::time(nullptr)); // Seed the random number generator
}

uint32_t CACHE::find_victim(uint32_t triggering_cpu, uint64_t instr_id, uint32_t set, const BLOCK* current_set, uint64_t ip, uint64_t full_addr, uint32_t type) {
    auto begin = std::next(std::begin(::binary_order[this]), set * NUM_WAY);
    auto end = std::next(begin, NUM_WAY);

    uint32_t victim = 0;
    for (uint32_t i = 0; i < NUM_WAY; ++i) {
        if (begin[i] == true) {
            victim = i;
            break;
        }
    }
    ::binary_order[this][set * NUM_WAY + victim] = true;
    return victim; 
}

void CACHE::update_replacement_state(uint32_t triggering_cpu, uint32_t set, uint32_t way, uint64_t full_addr, uint64_t ip, uint64_t victim_addr, uint32_t type, uint8_t hit) {
    double e = 1;
    if (std::rand() < e * RAND_MAX) {
        ::binary_order[this][set * NUM_WAY + way] = false;
    } else {
        ::binary_order[this][set * NUM_WAY + way] = true;
    }
}

void CACHE::replacement_final_stats() {}