From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [RFC] xenomai-images: test and demo image generator
Message-ID: <c32e5b83-4eec-f6f2-dd63-c1e5b753a78f@siemens.com>
Date: Tue, 6 Nov 2018 19:58:22 +0100
MIME-Version: 1.0
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
To: Xenomai <xenomai@xenomai.org>
Cc: Philippe Gerum <rpm@xenomai.org>, Leopold Palomo-Avellaneda <leo@alaxarxa.net>, Steven Seeger <steven.seeger@nasa.gov>

Hi all,

as I was (and still am) in the need to test also non-x86 from time to time, I
hacked up a little framework for generating bootable Debian images with Xenomai
pre-installed. It's currently hosted on my personal github space:

https://github.com/jan-kiszka/xenomai-images

I think we should move this over to the Xenomai group at gitlab.denx.de and
expand this step-wise with more archs (that QEMU support) as well as real
targets. I think I will add the HiKey board tomorrow, should be rather simple as
I did this for jailhouse-images [1], the inspiration and source of this layer,
just recently. Provided the ipipe kernel works fine with it.

Comments? Suggestions? Opinions?

Jan

[1] https://github.com/siemens/jailhouse-images

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

