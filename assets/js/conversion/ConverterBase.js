
export default class ConverterBase {

  // I know what your thinking, "What a waste of time!". For more complex objects and 
  // projects having separate conversion logic pays of big time. It just takes a year or two 
  // before you realize it 
  
  // ==========================================================================
	// Conversion
	// ==========================================================================

  // converts an item from one type to another
  convert(any) {
    return null;
  }

  // converts a list of items from one type to another 
  convertList(anyList) {
    if (anyList) {
      return anyList.map((item) => this.convert(item))
    }
    return [];
  }
  
}