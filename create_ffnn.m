function net = create_ffnn(nfaces, IMGDB)

net = network;

net.numInputs = 1;
net.numLayers = 2;

net.biasConnect = [1;1];

net.inputConnect = [1;0];

net.layerConnect = [0 0; 1 0 ];
                
net.outputConnect = [0 1];   

netInputs = ones (2160,2);
netInputs (1:2160,1)= 0;
net.inputs{1}.range = netInputs;

net.layers{1}.size = 100;
net.layers{2}.size = nfaces;

net.layers{1:2}.transferFcn = 'logsig';
net.layers{1:2}.initFcn = 'initnw';

net.initFcn = 'initlay';
net.performFcn = 'msereg';
net.trainFcn = 'trainscg';

net = init(net);

net.trainFcn = 'trainscg';
net.trainParam.lr = 0.4;
net.trainParam.epochs = 400;
net.trainParam.show = 10;
net.trainParam.goal = 1e-3;

T{1,1} = cell2mat(IMGDB(2,:));
Y{1,1} = cell2mat(IMGDB(3,:));
net = train(net,Y,T);

save net net