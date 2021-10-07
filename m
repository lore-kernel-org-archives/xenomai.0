Subject: Re: RTNET i.mx6 raw packets
References: <freemail.20211001100323.12881.1@fmxmldata07.freemail.hu>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <c75ef515-77a1-9d9f-deaa-fe13fe3239e7@siemens.com>
Date: Thu, 7 Oct 2021 10:12:11 +0200
MIME-Version: 1.0
In-Reply-To: <freemail.20211001100323.12881.1@fmxmldata07.freemail.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paal Tamas <paal_to@freemail.hu>, xenomai@xenomai.org, =?UTF-8?Q?Jean-Baptiste_Tr=c3=a9dez?= <jean-baptiste.tredez@ba-healthcare.com>

On 01.10.21 10:03, Paal Tamas via Xenomai wrote:
> Dear All, I would like to use RTNET with raw packets on the fec interface of my i.mx6 CPU. The purpose of the whole thing is to use the Soem ECAT master.
> I am lost. I need your help. Xenomai_3.1, kernel 4.14.78.I am using this rtnet fec patch:
> https://xenomai.org/pipermail/xenomai/2019-March/040580.html The fec interface is eth0.

There was a proposal to merge that change
(https://xenomai.org/pipermail/xenomai/2021-July/046000.html), and I
almost did but had to revert it again due to build issues
(https://xenomai.org/pipermail/xenomai/2021-August/046088.html). Any
news on this, Jean-Baptiste?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

