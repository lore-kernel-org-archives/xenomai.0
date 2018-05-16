References: <ca00a2b2-b44d-a25a-cb53-852a0f8e2d32@gmail.com>
 <594f0ba9-8e01-d2d2-a58e-2abcb3b72289@gmail.com>
 <fb226301-fe52-c9c9-f5a0-3f760b8d5492@gmail.com>
 <74da7f07-6df9-5a5f-ff63-b414437749b2@xenomai.org>
 <1dbe3f00-a866-248c-3799-a0d8efeee4e4@gmail.com>
 <e937a73f-ef0f-5394-bdae-400fcfe30ddb@gmail.com>
 <2e75fd33-8998-4cfb-6fa6-bef20f37f2dc@gmail.com>
 <e398a8e0-65f2-cd46-b502-0e81f5e6fee6@xenomai.org>
 <9c2a8966-09c2-cc32-9a7b-fe16339d9c80@gmail.com>
 <bd252434-25b7-e0c1-5a55-7e9321c48d8f@gmail.com>
 <6430f861-a017-02e8-ba19-9a75aedc9475@gmail.com>
 <b6be86e9-bc5a-c213-d458-219d8c4ecc01@xenomai.org>
From: Edouard Tisserant <edouard.tisserant@gmail.com>
Message-ID: <1a298a3a-7961-8ea1-9f2f-00a1b68d9f25@gmail.com>
Date: Wed, 16 May 2018 11:20:46 +0200
MIME-Version: 1.0
In-Reply-To: <b6be86e9-bc5a-c213-d458-219d8c4ecc01@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Xenomai] Crash with longer dlopen/dlcose sequence
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>


>>>> [Xenomai] bad syscall <0xf0002>

> Thanks for digging this out. Could you try this patch, keeping the relocation enabled in your build? TIA,

Works for me : No more "bad syscall" complain even if linking with some
non -fPIC compiled objects.



