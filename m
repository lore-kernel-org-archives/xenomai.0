Message-ID: <543B96FA.5090608@xenomai.org>
Date: Mon, 13 Oct 2014 11:10:18 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <9BA84827B30CBE4996725F98F7DC9123428E2849@SMExchange01.siebmeyer.org>
In-Reply-To: <9BA84827B30CBE4996725F98F7DC9123428E2849@SMExchange01.siebmeyer.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Threadnames not equal?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?IkjDpG5lbC1CYWFzLCBBbGV4YW5kZXIi?= <alexander.haenel-baas@sieb-meyer.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10/13/2014 10:47 AM, Hänel-Baas, Alexander wrote:
> Hi,
> 
> i have a main thread witch creates 3 other threads, this other thread was named
> with:  pthread_setname_np(hThread, "myName");.

Yes, Xenomai implemented pthread_set_name_np which is inconsistent with
the usual naming of pthread functions, then glibc added
pthread_setname_np. This is unfortunate. This was corrected in Xenomai
3.0, this will be backpored in Xenomai 2.6, but in the mean time, please
use the Xenomai function.

-- 
                                                                Gilles.

