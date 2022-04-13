Message-ID: <41a8bf39-676c-c28b-03a3-53788a4f7676@siemens.com>
Date: Wed, 13 Apr 2022 17:59:33 +0200
MIME-Version: 1.0
Subject: Re: Analogy supported DAQ
Content-Language: en-US
References: <075339687d602ea1c4c7841a79dff2d4@rtxi.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <075339687d602ea1c4c7841a79dff2d4@rtxi.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ivan@rtxi.org, xenomai@xenomai.org

On 12.04.22 18:36, Ivan F. Valerio via Xenomai wrote:
> Hello,
> 
> I am looking to use Xenomai's analogy to connect my application to a NI
> PCIe DAQ card. I found your list of supported hardware for analogy, and
> the only PCIe found in your list are no longer supported by National
> Instruments(PCIe-6251 & PCIe-6259). Are there any other PCIe cards
> supported by Analogy? How would I go about confirming compatibility with
> the newer NI PCIe cards?

Analogy was about to be removed from Xenomai because no one was
contributing updates to it in a long while, particularly -but not only-
drivers. One user raised his voice that at least the core is still used
(with out-of-tree drivers), so that move was postponed. In that light,
it is a bit unlikely that you get much more feedback.

We are surely open to new contributors "reviving" part of Analogy again,
specifically /wrt to newer hardware. The first step to assess the
efforts would likely be comparing older drivers and their manuals (or
kernel drivers, if any) to newer one, e.g. whether the register
interface is just an extension or rather something completely different.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

