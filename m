MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Date: Thu, 07 Nov 2013 13:31:44 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
In-Reply-To: <1383826877-8749-2-git-send-email-konradb3@gmail.com>
References: <1383826877-8749-1-git-send-email-konradb3@gmail.com>
 <1383826877-8749-2-git-send-email-konradb3@gmail.com>
Message-ID: <a441383b612eacb044e6fa8abb015e84@grandegger.com>
Subject: Re: [Xenomai]
	=?utf-8?q?=5BPATCH_2/2=5D_rtcan/peek=5Fpci=3A_add_suppo?=
	=?utf-8?q?rt_for_3_and_4_port_cards=2E?=
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Konrad Banachowicz <konradb3@gmail.com>
Cc: xenomai@xenomai.org

Hi Konrad,



could you please add 4 channel support as done for the corresponding Linux

driver:



  http://lxr.free-electrons.com/source/drivers/net/can/sja1000/peak_pci.c



The master/slave approach is ugly and does not scale properly.



On Thu,  7 Nov 2013 13:21:17 +0100, Konrad Banachowicz

<konradb3@gmail.com> wrote:

> ---

>  ksrc/drivers/can/sja1000/rtcan_peak_pci.c |   61

>  ++++++++++++++---------------

>  1 file changed, 30 insertions(+), 31 deletions(-)



Also please add a patch description next time.



Thanks,



Wolfgang.



