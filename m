From: "Yogi A. Patel" <yapatel@gatech.edu>
Message-ID: <56A69384.2040402@gatech.edu>
Date: Mon, 25 Jan 2016 16:28:36 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] cmd_write example 2.6.4
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi -

I'm trying to use the cmd_write example (as is provided with 2.6.4) to 
test asynchronous writing to analog outputs on my NI card however am 
having trouble running the example.

cat /proc/analogy/00-analogy_ni_pcimio
--  Subdevices --

| idx | type
|  00 | Analog input subdevice
|  01 | Analog output subdevice
|  02 | Digital input/output subdevice
|  03 | Unused subdevice
|  04 | Unused subdevice
|  05 | Calibration subdevice
|  06 | Memory subdevice
|  07 | Digital input/output subdevice
|  08 | Unused subdevice
|  09 | Serial subdevice
|  10 | Unused subdevice
|  11 | Counter subdevice
|  12 | Counter subdevice
|  13 | Counter subdevice

cat /proc/analogy/devices
--  Analogy devices --

| idx | status | driver
|  00 | Linked | analogy_ni_pcimio
|  01 | Unused | No driver
|  02 | Unused | No driver
|  03 | Unused | No driver
|  04 | Unused | No driver
|  05 | Unused | No driver
|  06 | Unused | No driver
|  07 | Unused | No driver
|  08 | Unused | No driver
|  09 | Unused | No driver

cat /proc/analogy/drivers
--  Analogy drivers --

| idx | driver name
|  00 | analogy_ni_pcimio
|  01 | analogy_8255

I have tried running the following different commands - however no luck 
driving the voltage output of either channel 0 or channel 1 of my NI 
card's analog outputs.

sudo ./cmd_write -v
cmd_write configuration:
RTDM device name: analogy0
Subdevice index: 0
Selected channels: 0,1
Selected range: 0,5,V
Scans count: 0
Wake count: 0

sudo ./cmd_write -v -danalogy0 -c0 -R0,10,V -S1000
cmd_write configuration:
RTDM device name: analogy0
Subdevice index: 0
Selected channels: 0
Selected range: 0,10,V
Scans count: 1000
Wake count: 0

sudo ./cmd_write -v -danalogy0 -c0,1 -R0,10,V -S1000
cmd_write configuration:
RTDM device name: analogy0
Subdevice index: 0
Selected channels: 0,1
Selected range: 0,10,V
Scans count: 1000
Wake count: 0

sudo ./cmd_write -v -danalogy0 -c0,1 -R0,10,V -S1000 -s1
cmd_write: no range found for 0,10,V
*** Error in `./cmd_write': double free or corruption (!prev): 
0x0000000001b4f180 ***

sudo ./cmd_write -v -danalogy0 -s1 -c0 -S10
cmd_write: no range found for 0,5,V
*** Error in `./cmd_write': double free or corruption (!prev): 
0x0000000000f7c180 ***

sudo ./cmd_write -v -danalogy0 -s1 -c0 -S10 -R0,5,V
cmd_write: no range found for 0,5,V
*** Error in `./cmd_write': double free or corruption (!prev): 
0x0000000001d09180 ***

sudo ./cmd_write -v -danalogy0 -s1 -c0 -S10 -R0,10,V
cmd_write: no range found for 0,10,V
*** Error in `./cmd_write': double free or corruption (!prev): 
0x000000000125a180 ***


However, I am able to use insn_write and successfully drive the outputs.

sudo ./insn_write -v -s1 -c0 -V65000
insn_write: device analogy0 opened (fd=0)
insn_write: basic descriptor retrieved
      subdevices count = 14
      read subdevice index = 0
      write subdevice index = 0
insn_write: complex descriptor retrieved
insn_write: selected subdevice index = 1
insn_write: channel width is 16 bits
insn_write: global scan size is 2
insn_write: writing raw value 0xfde8
insn_write: 2 bytes successfully sent

I was unable to find more documentation on the cmd_write - any 
thoughts/help appreciated.

