Message-ID: <526E697D.6030005@xenomai.org>
Date: Mon, 28 Oct 2013 14:41:17 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <C0EBEDB7-2439-4083-AF21-4896462E5B7E@gmail.com>
 <526E3407.9050400@xenomai.org>
 <072A853B-9DEA-4272-B2CA-88CA5FFCD8B1@gmail.com>
In-Reply-To: <072A853B-9DEA-4272-B2CA-88CA5FFCD8B1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Static linking fails for global mutex variable(c++
 class) on embedded system
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Jaap Kempenaar <janjaapkempenaar@gmail.com>
Cc: xenomai@xenomai.org

On 10/28/2013 02:36 PM, Jan Jaap Kempenaar wrote:
> How exactly is the xenomai library initialised?

Witch a function having the "constructor" attribute which makes it
executed before main, but does not give any guarantee that it will be
executed before a C++ static object constructor.

> Is this a kind of system function call performed by the application?

Yes.

>
> Can you check whether or not the xenomai library is initialised at a
> certain point in the application?

Well, if pthread_mutex_init returns ENOSYS, it means that it is not
initialized. Also, when entering the "main" function, you are sure that 
the library has been initialized.

>
> As for the wrap-link.sh, we use that in our static linking.

Ok.

-- 
					    Gilles.

