MIME-Version: 1.0
From: Ashok kumar <ashokkumar.bb@gmail.com>
Date: Tue, 12 Jun 2018 09:32:54 +0530
Message-ID: <CAFUnMknHMJMGT4v0MwGP=gPoY4J=WUbtjA2VPzRGk5n+3BHtpA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] how to install module xeno_rtdm xeno_hal xeno_nucleus to
	use RTnet
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I am using xenomai -2.6.2.1 and I have patched the xenomai -2.6.2.1
with linux kernel 3.4.6
and I installed using the following commands

sudo make-kpkg --bzimage --initrd --append-to-version=3D-xenomai-2.6.4
-j8 kernel-image kernel-headers modules
# Install kernel
cd ..
sudo dpkg -i linux-image-*.deb
sudo dpkg -i linux-headers-*.deb

sudo ../xenomai-2.6.4/configure --enable-shared --enable-smp --enable-x86-s=
ep
sudo make -j8
sudo make install

cd /etc/ld.so.conf.d/
sudo touch xenomai.conf
sudo sh -c "echo '/usr/xenomai/lib' >> xenomai.conf"
sudo ldconfig

echo "export PATH=3D$PATH:/usr/xenomai/bin" >> ~/.bashrc
# echo "export PATH=3D$PATH:/usr/xenomai/bin:/usr/xenomai/lib:/usr/xenomai/=
include"
>> ~/.bashrc
sudo su
echo "export PATH=3D$PATH:/usr/xenomai/bin" >> ~/.bashrc
# echo "export PATH=3D$PATH:/usr/xenomai/bin:/usr/xenomai/lib:/usr/xenomai/=
include"
>> ~/.bashr
************************************************* *************************=
***
after installing xenomai-2.6.4 with linux kernel 3.4.6
I am not able to get the module in the xenomai directory, to use  RTnet

=E2=80=8CI  required to load the modules  for RTnet operations
sudo modprobe xeno_rtdm
sudo modprobe xeno_hal
sudo modprobe xeno_nucleus

after executing this command I am using lsmod to view these modules
,but the modules are not getting loaded.

In /usr/xenomai I am not able to see the modules.

help me to get the following module xeno_rtdm, xeno_hal, xeno_nucleus
install to use the rtnet


Thank you
R. Ashokkumar

