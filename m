Message-ID: <f5cc93f2-3a42-ff05-a7d2-e4b1de56d2ff@celinsrl.com>
Date: Fri, 5 Nov 2021 13:48:55 +0100
MIME-Version: 1.0
From: Lorenzo Battini <l.battini@celinsrl.com>
Subject: ABI Mismatch
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello support team!

I am writing to you because i have a problem with
the Xenomai library and my patched kernel.

I patched and compiled the Linux 5.4.151 kernel using
IPIPE and i built the Xenomai 3.1.1 library.

Running the installed kernel and trying to use the library
launching: "sudo /<installationPath>/bin/latency"
gives me the error:
"ABI mismatch: required r18, provided r17"

and if i install a compiled 3.0 version of Xenomai library
and rty the same test, i get the error:
"ABI mismatch: required r16, provided r17"

it seems i cannot have the r17 version of ABI.

What may i have to check?

Thank you so much in advance!

L

