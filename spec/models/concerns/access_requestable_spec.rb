require 'spec_helper'

describe AccessRequestable do
  describe 'Group' do
    describe '#request_access' do
      let(:group) { create(:group, :public) }
      let(:user) { create(:user) }

      it { expect(group.request_access(user)).to be_a(GroupMember) }
      it { expect(group.request_access(user).user).to be_nil }
      it { expect(group.request_access(user).created_by).to eq(user) }
    end

    describe '#access_requested?' do
      let(:group) { create(:group, :public) }
      let(:user) { create(:user) }

      before { group.request_access(user) }

      it { expect(group.access_requested?(user)).to be_truthy }
    end
  end

  describe 'Project' do
    describe '#request_access' do
      let(:project) { create(:empty_project, :public) }
      let(:user) { create(:user) }

      it { expect(project.request_access(user)).to be_a(ProjectMember) }
    end

    describe '#access_requested?' do
      let(:project) { create(:empty_project, :public) }
      let(:user) { create(:user) }

      before { project.request_access(user) }

      it { expect(project.access_requested?(user)).to be_truthy }
    end
  end
end
