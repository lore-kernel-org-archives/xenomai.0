MIME-Version: 1.0
From: John Ho <johnho26@gmail.com>
Date: Tue, 27 Oct 2020 18:26:22 +0100
Message-ID: <CAMjL99JY9ZYCdgZnMLhfaiSsvJ_m5uESZYw67UAWMKxRX_04gA@mail.gmail.com>
Subject: Issue to start orocos on Xenomai
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi all, I wish to ask for some help with orocos that is patched with
xenomai. I was able to compile Orocos with xenomai integration, however, I
face an issue whenever I start deployer-corba-xenomai. When i start
deployer-xenomai, it works like default deployer, whereby i am allowed to
input commands in. However when i start deployer-corba-xenomai, I encounter
this issue where it only shows : Real-time memory: ******* bytes free of
******** allocated. Nothing else will show after that part. I am unsure
where i could have gone wrong with the installation since i did not get any
error message from catkin build.

this is the exact steps that i took:

export OROCOS_TARGET=xenomai

mkdir -p ~/john/orocos-2.9_ws/srccd ~/john/orocos-2.9_ws/src# Get all
the packages
wstool init
wstool merge https://raw.githubusercontent.com/kuka-isir/rtt_lwr/rtt_lwr-2.0/lwr_utils/config/orocos_toolchain-2.9.rosinstall
wstool update -j2# Get the latest updates (OPTIONAL)cd orocos_toolchain
git submodule foreach git checkout toolchain-2.9
git submodule foreach git pull
cd ~/john/orocos-2.9_ws/
cd src/orocos_toolchain/rtt
rm -rf rtt
git clone https://github.com/ahoarau/rtt.git
git checkout xenomai3-support-v3
cd ~/john/orocos-2.9_ws/# Install dependenciessource /opt/ros/melodic/setup.bash
rosdep install --from-paths ~/john/orocos-2.9_ws/src --ignore-src
--rosdistro melodic -y -r# Configure the build in Release
(recommended), and enable extra transport methods (optional)
catkin config --init --install --extend /opt/ros/melodic/ --cmake-args
-DCMAKE_BUILD_TYPE=Release -DENABLE_MQ=ON -DENABLE_CORBA=ON
-DCORBA_IMPLEMENTATION=OMNIORB# Build
catkin build
