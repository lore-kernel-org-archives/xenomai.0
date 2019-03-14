From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Mapping unchached memory with UDD
Message-ID: <c0aefe52-0ba1-72fb-88d8-edc1fc73880e@grandegger.com>
Date: Thu, 14 Mar 2019 11:38:53 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

Hello,

I'm writing a little UDD driver to handling interrupts and shared memory
to communicate with a co-processor. Is it possible to setup and map a
"mem_region" for *uncahced* memory. Will it be automatically uncached if
it's of type UDD_MEM_PHY?

TIA,

Wolfgang.

