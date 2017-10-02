References: <DB6PR0701MB245612C4904BA6543FFE09F0B57D0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <a44088a0-fe9c-92c1-ede4-37a076772e1a@xenomai.org>
Date: Mon, 2 Oct 2017 15:52:19 +0200
MIME-Version: 1.0
In-Reply-To: <DB6PR0701MB245612C4904BA6543FFE09F0B57D0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] PTHREAD_COND_INITIALIZER
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Giulio Moro <g.moro@qmul.ac.uk>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10/02/2017 12:39 PM, Giulio Moro wrote:
> The Xenomai documentation for pthread_cond_variable says 
> "Note that only pthread_cond_init() may be used to initialize a condition variable, using the static initializer PTHREAD_COND_INITIALIZER is not supported."
> 
> However, demo/posix/cyclictest/cyclictest.c has the following line:
>     static pthread_cond_t refresh_on_max_cond = PTHREAD_COND_INITIALIZER;
> which seems to contradict the above prescription.
> 

The doc. was not updated following a feature addition. Convar and mutex
initializers are available.

-- 
Philippe.

