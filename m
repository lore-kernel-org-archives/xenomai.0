Subject: Re: xenomai supported_cpus
References: <CAMjL99+f-zoDgY8-UxBvtUSr0phFW2jZ0SWrFaCEdz42o8-_TA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <30e9341c-d72c-8cbf-2e6a-d6563410c2f9@siemens.com>
Date: Thu, 29 Jul 2021 11:01:48 +0200
MIME-Version: 1.0
In-Reply-To: <CAMjL99+f-zoDgY8-UxBvtUSr0phFW2jZ0SWrFaCEdz42o8-_TA@mail.gmail.com>
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
To: John Ho <johnho26@gmail.com>, xenomai@xenomai.org

On 29.07.21 10:51, John Ho via Xenomai wrote:
> Hi all, I wish to ask about core isolation, and how to define the grub
> command line with regards to supported_cpus. As of right now, I have done
> the isolcpus and singled out Core 2-5 for xenomai, however, as for
> xenomai.supported_cpus, I am unsure what value I am supposed to put into
> the grub. Is there any documentation on this, so that I can adjust the
> value to this 4 cores?  Will appreciate any help with this

There is unfortunately no proper documentation. Feel free to add one,
likely to doc/asciidoc/README.INSTALL.adoc.

supported_cpus is a bitmask (in contrast to isolcpus, unfortunately).
So, to limit Xenomai to CPU 2-5, you need to specify 0x3c.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

