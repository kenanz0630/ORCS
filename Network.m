% define network class 

classdef Network
    properties (Access = public)
        nn
        na
        frstout
        lstout
        anode
        bnode
        sat
        tau0
        
        no
        orgid
        startod
        nod
        dest
        od_demand
    end
    
    methods
        function obj = Network(fname1,fname2)
            [obj.nn,obj.frstout,obj.lstout,obj.na,...
                obj.anode,obj.bnode,obj.sat,lngth,vmax] = read1(fname1);
            obj.tau0=lngth./vmax;
            [obj.no,obj.orgid,obj.startod,obj.nod, ...
                obj.dest, obj.od_demand]  = read2(fname2);
        end
    end
end

            
        