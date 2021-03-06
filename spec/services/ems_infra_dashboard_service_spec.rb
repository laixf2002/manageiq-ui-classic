describe EmsInfraDashboardService do
  context '#recentVms' do
    before do
      @ems1 = FactoryGirl.create(:ems_infra)
      @vm1 = FactoryGirl.create(:vm_infra, :ext_management_system => @ems1)
      @vm2 = FactoryGirl.create(:vm_infra, :ext_management_system => @ems1, :created_on => 1.day.ago.utc)

      @host1 = FactoryGirl.create(:host, :ext_management_system => @ems1)
      @host2 = FactoryGirl.create(:host, :ext_management_system => @ems1, :created_on => 1.day.ago.utc)

      @ems2 = FactoryGirl.create(:ems_infra)
      @vm3 = FactoryGirl.create(:vm_infra, :ext_management_system => @ems2)

      @host4 = FactoryGirl.create(:host, :ext_management_system => @ems2)
    end

    subject { EmsInfraDashboardService.new(@ems1.id, "ems_infra", EmsInfra) }

    it 'returns vms for a specified provider' do
      expect(subject.recent_vms_data[:recentResources][:xData].count).to eq(2)
      expect(subject.recent_vms_data[:recentResources][:yData].count).to eq(2)
    end

    it 'returns hosts for a specified provider' do
      expect(subject.recent_hosts_data[:recentResources][:xData].count).to eq(2)
      expect(subject.recent_hosts_data[:recentResources][:yData].count).to eq(2)
    end
  end
end
