<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Make-&-Sell.com | Create & Sell Your Products</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .canvas-container {
            position: relative;
            width: 100%;
            height: 500px;
            border: 2px dashed #ccc;
            background-color: #f9fafb;
            overflow: hidden;
        }
        
        #design-canvas {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
        }
        
        .tool-btn.active {
            /* Using a darker green for active state */
            background-color: #2F7449; 
            color: white;
        }
        
        .shape {
            position: absolute;
            cursor: move;
            user-select: none;
        }
        
        .resize-handle {
            position: absolute;
            width: 10px;
            height: 10px;
            background-color: white;
            /* Changed handle border to green */
            border: 2px solid #3c8257; 
            border-radius: 50%;
            z-index: 10;
        }
        
        .rotate-handle {
            position: absolute;
            width: 15px;
            height: 15px;
            background-color: white;
            /* Changed handle border to green */
            border: 2px solid #3c8257; 
            border-radius: 50%;
            z-index: 10;
            cursor: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="%233c8257" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 2v4M12 18v4M4.93 4.93l2.83 2.83M16.24 16.24l2.83 2.83M2 12h4M18 12h4M4.93 19.07l2.83-2.83M16.24 7.76l2.83-2.83"/></svg>'), auto;
        }
        
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }
        
        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
        }
        
        .feature-card {
            transition: all 0.3s ease;
        }
        
        .dropdown-content {
            display: none;
            position: absolute;
            min-width: 160px;
            box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
            z-index: 1;
        }
        
        .dropdown:hover .dropdown-content {
            display: block;
        }
        
        /* Custom scrollbar */
        ::-webkit-scrollbar {
            width: 8px;
        }
        
        ::-webkit-scrollbar-track {
            background: #f1f1f1;
        }
        
        ::-webkit-scrollbar-thumb {
            background: #888;
            border-radius: 4px;
        }
        
        ::-webkit-scrollbar-thumb:hover {
            background: #555;
        }
    </style>
</head>
<body class="bg-gray-50 font-sans">
    <nav class="bg-white shadow-lg sticky top-0 z-50">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-16">
                <div class="flex items-center">
                    <div class="flex-shrink-0 flex items-center">
                        <img src="http://googleusercontent.com/file_content/1" alt="Make-&-Sell.com Logo" class="h-10 w-auto">
                    </div>
                    <div class="hidden md:ml-10 md:flex md:space-x-8">
                        <a href="#" class="border-[#3c8257] text-gray-900 inline-flex items-center px-1 pt-1 border-b-2 text-sm font-medium">Home</a>
                        <a href="#" class="border-transparent text-gray-500 hover:border-gray-300 hover:text-gray-700 inline-flex items-center px-1 pt-1 border-b-2 text-sm font-medium">Marketplace</a>
                        <a href="#" class="border-transparent text-gray-500 hover:border-gray-300 hover:text-gray-700 inline-flex items-center px-1 pt-1 border-b-2 text-sm font-medium">Templates</a>
                        <a href="#" class="border-transparent text-gray-500 hover:border-gray-300 hover:text-gray-700 inline-flex items-center px-1 pt-1 border-b-2 text-sm font-medium">Pricing</a>
                    </div>
                </div>
                <div class="hidden md:ml-6 md:flex md:items-center">
                    <button class="bg-[#3c8257] hover:bg-[#2F7449] text-white px-4 py-2 rounded-md text-sm font-medium transition duration-300 flex items-center">
                        <i class="fas fa-plus mr-2"></i> New Project
                    </button>
                    <div class="ml-4 relative flex-shrink-0">
                        <div class="h-8 w-8 rounded-full bg-green-100 flex items-center justify-center cursor-pointer">
                            <span class="text-[#3c8257] font-medium">JS</span>
                        </div>
                    </div>
                </div>
                <div class="-mr-2 flex items-center md:hidden">
                    <button type="button" class="inline-flex items-center justify-center p-2 rounded-md text-gray-400 hover:text-gray-500 hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-inset focus:ring-[#3c8257]" aria-controls="mobile-menu" aria-expanded="false">
                        <span class="sr-only">Open main menu</span>
                        <i class="fas fa-bars"></i>
                    </button>
                </div>
            </div>
        </div>
    </nav>

    <div class="bg-gradient-to-r from-[#3c8257] to-[#F59E0B] text-white py-16">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="lg:grid lg:grid-cols-2 lg:gap-8 items-center">
                <div class="mb-12 lg:mb-0">
                    <h1 class="text-4xl font-extrabold tracking-tight sm:text-5xl lg:text-6xl mb-6">
                        Create, Customize & Sell Your Products
                    </h1>
                    <p class="text-xl text-green-100 mb-8">
                        The easiest way to design, prototype and sell your custom products. No CAD experience needed!
                    </p>
                    <div class="flex flex-col sm:flex-row gap-4">
                        <button class="bg-white text-[#3c8257] hover:bg-green-50 px-6 py-3 rounded-lg font-medium text-lg shadow-lg transition duration-300 flex items-center justify-center">
                            <i class="fas fa-play-circle mr-2"></i> Watch Demo
                        </button>
                        <button class="bg-transparent border-2 border-white hover:bg-[#F59E0B] px-6 py-3 rounded-lg font-medium text-lg transition duration-300 flex items-center justify-center">
                            <i class="fas fa-rocket mr-2"></i> Start Creating
                        </button>
                    </div>
                </div>
                <div class="relative">
                    <div class="bg-white/20 backdrop-blur-sm rounded-xl p-4 shadow-2xl">
                        <div class="canvas-container">
                            <canvas id="hero-canvas" width="600" height="400"></canvas>
                        </div>
                        <div class="flex justify-center mt-4 space-x-2">
                            <button class="bg-white text-[#3c8257] p-2 rounded-full shadow-md">
                                <i class="fas fa-cube"></i>
                            </button>
                            <button class="bg-white text-[#3c8257] p-2 rounded-full shadow-md">
                                <i class="fas fa-vector-square"></i>
                            </button>
                            <button class="bg-white text-[#3c8257] p-2 rounded-full shadow-md">
                                <i class="fas fa-text-height"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        <div class="grid grid-cols-1 lg:grid-cols-4 gap-6">
            <div class="lg:col-span-1 bg-white rounded-lg shadow-md p-4">
                <h2 class="text-lg font-semibold mb-4 text-gray-800 border-b pb-2">Design Tools</h2>
                
                <div class="space-y-2">
                    <div class="dropdown relative">
                        <button class="w-full flex items-center justify-between px-3 py-2 bg-gray-100 hover:bg-gray-200 rounded-md text-gray-700">
                            <span><i class="fas fa-shapes mr-2"></i> Shapes</span>
                            <i class="fas fa-chevron-down text-xs"></i>
                        </button>
                        <div class="dropdown-content bg-white rounded-md mt-1 p-2">
                            <button class="tool-btn w-full text-left px-3 py-2 hover:bg-orange-50 rounded-md flex items-center" data-tool="rectangle">
                                <i class="fas fa-square mr-2 text-[#F59E0B]"></i> Rectangle
                            </button>
                            <button class="tool-btn w-full text-left px-3 py-2 hover:bg-orange-50 rounded-md flex items-center" data-tool="circle">
                                <i class="fas fa-circle mr-2 text-[#F59E0B]"></i> Circle
                            </button>
                            <button class="tool-btn w-full text-left px-3 py-2 hover:bg-orange-50 rounded-md flex items-center" data-tool="triangle">
                                <i class="fas fa-play mr-2 text-[#F59E0B] rotate-90"></i> Triangle
                            </button>
                            <button class="tool-btn w-full text-left px-3 py-2 hover:bg-orange-50 rounded-md flex items-center" data-tool="line">
                                <i class="fas fa-minus mr-2 text-[#F59E0B]"></i> Line
                            </button>
                        </div>
                    </div>
                    
                    <button class="tool-btn w-full flex items-center px-3 py-2 bg-gray-100 hover:bg-gray-200 rounded-md text-gray-700" data-tool="text">
                        <i class="fas fa-font mr-2"></i> Text
                    </button>
                    
                    <button class="tool-btn w-full flex items-center px-3 py-2 bg-gray-100 hover:bg-gray-200 rounded-md text-gray-700" data-tool="image">
                        <i class="fas fa-image mr-2"></i> Image
                    </button>
                    
                    <div class="dropdown relative">
                        <button class="w-full flex items-center justify-between px-3 py-2 bg-gray-100 hover:bg-gray-200 rounded-md text-gray-700">
                            <span><i class="fas fa-paint-brush mr-2"></i> Advanced</span>
                            <i class="fas fa-chevron-down text-xs"></i>
                        </button>
                        <div class="dropdown-content bg-white rounded-md mt-1 p-2">
                            <button class="tool-btn w-full text-left px-3 py-2 hover:bg-orange-50 rounded-md flex items-center" data-tool="extrude">
                                <i class="fas fa-cube mr-2 text-[#F59E0B]"></i> 3D Extrude
                            </button>
                            <button class="tool-btn w-full text-left px-3 py-2 hover:bg-orange-50 rounded-md flex items-center" data-tool="boolean">
                                <i class="fas fa-code-branch mr-2 text-[#F59E0B]"></i> Boolean Operations
                            </button>
                            <button class="tool-btn w-full text-left px-3 py-2 hover:bg-orange-50 rounded-md flex items-center" data-tool="fillet">
                                <i class="fas fa-circle-notch mr-2 text-[#F59E0B]"></i> Fillet/Chamfer
                            </button>
                        </div>
                    </div>
                </div>
                
                <h2 class="text-lg font-semibold mt-6 mb-4 text-gray-800 border-b pb-2">Properties</h2>
                
                <div id="properties-panel" class="space-y-4">
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Fill Color</label>
                        <div class="flex items-center">
                            <input type="color" id="fill-color" value="#F59E0B" class="w-8 h-8 border rounded cursor-pointer">
                            <input type="text" id="fill-color-value" value="#F59E0B" class="ml-2 px-2 py-1 border rounded text-sm w-20">
                        </div>
                    </div>
                    
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Stroke Color</label>
                        <div class="flex items-center">
                            <input type="color" id="stroke-color" value="#3c8257" class="w-8 h-8 border rounded cursor-pointer">
                            <input type="text" id="stroke-color-value" value="#3c8257" class="ml-2 px-2 py-1 border rounded text-sm w-20">
                        </div>
                    </div>
                    
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Stroke Width</label>
                        <input type="range" id="stroke-width" min="0" max="10" value="2" class="w-full">
                        <div class="text-xs text-gray-500 text-right">2px</div>
                    </div>
                    
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Opacity</label>
                        <input type="range" id="opacity" min="0" max="100" value="100" class="w-full">
                        <div class="text-xs text-gray-500 text-right">100%</div>
                    </div>
                    
                    <div id="text-properties" class="hidden">
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">Text Content</label>
                            <textarea id="text-content" rows="2" class="w-full px-2 py-1 border rounded text-sm"></textarea>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">Font Size</label>
                            <input type="range" id="font-size" min="8" max="72" value="16" class="w-full">
                            <div class="text-xs text-gray-500 text-right">16px</div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="lg:col-span-2">
                <div class="bg-white rounded-lg shadow-md p-4">
                    <div class="flex justify-between items-center mb-4">
                        <h2 class="text-lg font-semibold text-gray-800">Product Designer</h2>
                        <div class="flex space-x-2">
                            <button class="bg-gray-100 hover:bg-gray-200 p-2 rounded-md text-gray-700">
                                <i class="fas fa-layer-group"></i>
                            </button>
                            <button class="bg-gray-100 hover:bg-gray-200 p-2 rounded-md text-gray-700">
                                <i class="fas fa-undo"></i>
                            </button>
                            <button class="bg-gray-100 hover:bg-gray-200 p-2 rounded-md text-gray-700">
                                <i class="fas fa-redo"></i>
                            </button>
                            <button class="bg-[#F59E0B] hover:bg-[#E28A00] text-white px-3 py-1 rounded-md text-sm font-medium">
                                <i class="fas fa-save mr-1"></i> Save
                            </button>
                        </div>
                    </div>
                    
                    <div class="canvas-container" id="main-canvas-container">
                        <canvas id="design-canvas"></canvas>
                    </div>
                    
                    <div class="flex justify-between mt-4">
                        <div class="flex space-x-2">
                            <button class="bg-gray-100 hover:bg-gray-200 p-2 rounded-md text-gray-700">
                                <i class="fas fa-eye"></i> Preview
                            </button>
                            <button class="bg-gray-100 hover:bg-gray-200 p-2 rounded-md text-gray-700">
                                <i class="fas fa-cube"></i> 3D View
                            </button>
                        </div>
                        <button class="bg-[#3c8257] hover:bg-[#2F7449] text-white px-4 py-2 rounded-md font-medium">
                            <i class="fas fa-shopping-cart mr-2"></i> Publish to Marketplace
                        </button>
                    </div>
                </div>
                
                <div class="bg-white rounded-lg shadow-md p-4 mt-6">
                    <h2 class="text-lg font-semibold mb-4 text-gray-800 border-b pb-2">Product Details</h2>
                    
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">Product Name</label>
                            <input type="text" class="w-full px-3 py-2 border rounded-md" placeholder="My Awesome Product">
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">Category</label>
                            <select class="w-full px-3 py-2 border rounded-md">
                                <option>Home Decor</option>
                                <option>Jewelry</option>
                                <option>Tech Accessories</option>
                                <option>Fashion</option>
                                <option>Toys & Games</option>
                            </select>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">Price ($)</label>
                            <input type="number" class="w-full px-3 py-2 border rounded-md" placeholder="19.99">
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">Materials</label>
                            <select class="w-full px-3 py-2 border rounded-md">
                                <option>PLA Plastic</option>
                                <option>ABS Plastic</option>
                                <option>Wood</option>
                                <option>Metal</option>
                                <option>Ceramic</option>
                            </select>
                        </div>
                        <div class="md:col-span-2">
                            <label class="block text-sm font-medium text-gray-700 mb-1">Description</label>
                            <textarea rows="3" class="w-full px-3 py-2 border rounded-md" placeholder="Describe your product..."></textarea>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="lg:col-span-1 bg-white rounded-lg shadow-md p-4">
                <h2 class="text-lg font-semibold mb-4 text-gray-800 border-b pb-2">Layers</h2>
                <div class="space-y-2" id="layers-panel">
                    <div class="flex justify-between items-center bg-gray-100 p-2 rounded-md hover:bg-gray-200">
                        <span>Layer 1 (Rectangle)</span>
                        <div class="flex space-x-2">
                            <button class="text-gray-500 hover:text-gray-700"><i class="fas fa-eye"></i></button>
                            <button class="text-gray-500 hover:text-gray-700"><i class="fas fa-lock"></i></button>
                        </div>
                    </div>
                </div>

                <h2 class="text-lg font-semibold mt-6 mb-4 text-gray-800 border-b pb-2">Marketplace</h2>
                <div class="grid grid-cols-2 gap-4">
                    <div class="bg-gray-100 p-3 rounded-lg text-center feature-card">
                        <i class="fas fa-tshirt text-[#F59E0B] text-2xl mb-2"></i>
                        <p class="text-sm font-medium">Apparel</p>
                    </div>
                    <div class="bg-gray-100 p-3 rounded-lg text-center feature-card">
                        <i class="fas fa-mug-hot text-[#F59E0B] text-2xl mb-2"></i>
                        <p class="text-sm font-medium">Mugs</p>
                    </div>
                    <div class="bg-gray-100 p-3 rounded-lg text-center feature-card">
                        <i class="fas fa-mobile-alt text-[#F59E0B] text-2xl mb-2"></i>
                        <p class="text-sm font-medium">Phone Cases</p>
                    </div>
                    <div class="bg-gray-100 p-3 rounded-lg text-center feature-card">
                        <i class="fas fa-cogs text-[#F59E0B] text-2xl mb-2"></i>
                        <p class="text-sm font-medium">Components</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <footer class="bg-gray-800 text-white py-8 mt-12">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
            <p>&copy; 2025 Make-&-Sell.com. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>
