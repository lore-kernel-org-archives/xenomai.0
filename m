Subject: Re: ABI Mismatch
References: <f5cc93f2-3a42-ff05-a7d2-e4b1de56d2ff@celinsrl.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <c590718c-f137-cc16-7166-be80e9a7c1fb@siemens.com>
Date: Fri, 5 Nov 2021 15:39:00 +0100
MIME-Version: 1.0
In-Reply-To: <f5cc93f2-3a42-ff05-a7d2-e4b1de56d2ff@celinsrl.com>
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
To: Lorenzo Battini <l.battini@celinsrl.com>, xenomai@xenomai.org

On 05.11.21 13:48, Lorenzo Battini via Xenomai wrote:
> Hello support team!
> 
> I am writing to you because i have a problem with
> the Xenomai library and my patched kernel.
> 
> I patched and compiled the Linux 5.4.151 kernel using
> IPIPE and i built the Xenomai 3.1.1 library.
> 
> Running the installed kernel and trying to use the library
> launching: "sudo /<installationPath>/bin/latency"
> gives me the error:
> "ABI mismatch: required r18, provided r17"

This means your kernel is 3.1-based while userland is 3.2-based
(master/next/-rcX).

> 
> and if i install a compiled 3.0 version of Xenomai library
> and rty the same test, i get the error:
> "ABI mismatch: required r16, provided r17"

And here you switched to 3.0 userland but actually kept the kernel at
Xenomai 3.1.

Jan

> 
> it seems i cannot have the r17 version of ABI.
> 
> What may i have to check?
> 
> Thank you so much in advance!
> 
> L
> 

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

