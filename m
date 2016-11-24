From: Florian Richer <florian.richer@upmc.fr>
References: <4318702e-51ea-f276-55b0-490fdc13fffd@isir.upmc.fr>
 <20160426142028.GD27058@hermes.click-hack.org>
 <4e3bc939-1942-1e78-9551-fffe95204fef@isir.upmc.fr>
 <20160429194212.GP1881@hermes.click-hack.org>
 <d05a6592-b473-2a12-2e71-f9b067e2c83d@isir.upmc.fr>
Message-ID: <0a32eabf-94bd-794a-407a-46a7926e83f5@upmc.fr>
Date: Thu, 24 Nov 2016 16:50:42 +0100
MIME-Version: 1.0
In-Reply-To: <d05a6592-b473-2a12-2e71-f9b067e2c83d@isir.upmc.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Latency test shows weird results
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
Cc: xenomai@xenomai.org

Hello,

In case someone is having similar issues, this problem seems to have 
disappeared (latency ran for a whole week without any overrun or high 
latencies) after a microcode update :

CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=Y

& on lubuntu :
apt-get install intel-microcode

dmesg now shows :
microcode: CPU0 sig=0x695, pf=0x80, revision=0x2
microcode: CPU0 updated to revision 0x47, date = 2004-11-09

This is on a Pentium M 1300.

Florian

