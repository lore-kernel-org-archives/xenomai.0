From: Jake Burris <jakeburris7@gmail.com>
Message-ID: <e0a47fd9-7ea7-63af-8834-55cd72f086eb@gmail.com>
Date: Wed, 11 Jul 2018 15:07:37 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: [Xenomai] Xenomai on VAR-SOM-MX6
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

I am trying to get the Xenomai Cobalt kernel onto a Variscite 
VAR-SOM-MX6 Test Board featuring a NXP i.MX6 quad-core processor. I am 
having issues with the user space(a xenomai folder is not showing up in 
/usr). We are using a Debian Stretch OS kernel 4.9.38 with the same 
IPIPE patch and Xenomai 3. I am having issues finding the latency test 
as well as xeno-tests. Is there a specific option that we have to select 
in menuconfig in order for these to show up. When I type dmesg | grep -i 
"Xenomai" after booting the three Xenomai messages are there.

Please advise,

Jake


