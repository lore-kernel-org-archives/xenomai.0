Message-ID: <c024fefc0811201603k4f99f2aap28645594b0167198@domain.hid>
Date: Fri, 21 Nov 2008 09:03:05 +0900
From: "Adrian Boeing" <me@domain.hid>
Sender: aboeing@domain.hid
In-Reply-To: <3f7e4e30c68612bf269e955922cf6f82.squirrel@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_166757_20774957.1227225785600"
References: <c024fefc0811200055r309fbedar73531c856f27565a@domain.hid>
	<3f7e4e30c68612bf269e955922cf6f82.squirrel@domain.hid>
Subject: Re: [Xenomai-help] Interprocess Mutex
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

------=_Part_166757_20774957.1227225785600
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Gilles, thanks for the reply.

In my test (pseudo) code with rt_mutex:
(without bind):
int main() {
 err = rt_mutex_create(&mutex_desc,0);
 err =  rt_mutex_acquire(&mutex_desc,TM_INFINITE); //fails with -1!
}
(with bind):
int main() {
 err = rt_mutex_create(&Kmutex_desc,"bob");
 err = rt_mutex_bind(&mutex_desc,"bob",TM_INFINITE);
 err =  rt_mutex_acquire(&mutex_desc,TM_INFINITE); //fails with -1!
}

Both of these fail to acquire the mutex with "EPERM" :: (this service was
called from a context which cannot be given the ownership of the mutex).

Is there something special I need to do in order to do this in user space?

Thanks,
-Adrian

On Thu, Nov 20, 2008 at 9:48 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

>
> Adrian Boeing wrote:
> > Hi,
> >
> > Is it possible to create an inter-process mutex between kernel space and
> > user space?
> > If so, how is this done with the native API?
> >
> > The system has one real-time kernel process which communicates with other
> > processes via shared memory.
>
> See rt_mutex_bind:
>
> http://www.xenomai.org/documentation/branches/v2.4.x/html/api/group__mutex.html#g39b3a0e7f6f6ee41b8068ed59e25d1d1
> or, for the posix skin, pthread_mutexattr_setpshared:
>
> http://www.xenomai.org/documentation/branches/v2.4.x/html/api/group__posix__mutex.html#g73bd8697b91e0ee9a63c30052ac9f72f
> Note that for sharing a mutex with the posix skin, the pthread_mutex_t
> structure needs to reside on a shared memory.
>
> --
>                     Gilles.
>
>

------=_Part_166757_20774957.1227225785600
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Gilles, thanks for the reply.<br><br>In my test (pseudo) code with rt_mutex:<br>(without bind):<br>int main() {<br>&nbsp;err = rt_mutex_create(&amp;mutex_desc,0);<br>&nbsp;err =&nbsp; rt_mutex_acquire(&amp;mutex_desc,TM_INFINITE); //fails with -1!<br>
}<br>(with bind):<br>int main() {<br>&nbsp;err = rt_mutex_create(&amp;Kmutex_desc,&quot;bob&quot;);<br>&nbsp;err = rt_mutex_bind(&amp;mutex_desc,&quot;bob&quot;,TM_INFINITE);<br>&nbsp;err =&nbsp; rt_mutex_acquire(&amp;mutex_desc,TM_INFINITE); //fails with -1!<br>
}<br><br>Both of these fail to acquire the mutex with &quot;EPERM&quot; :: (this service was called from a context which cannot be given the ownership of the mutex).<br><br>Is there something special I need to do in order to do this in user space?<br>
<br>Thanks,<br>-Adrian<br><br><div class="gmail_quote">On Thu, Nov 20, 2008 at 9:48 PM, Gilles Chanteperdrix <span dir="ltr">&lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><div></div><div class="Wj3C7c"><br>
Adrian Boeing wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; Is it possible to create an inter-process mutex between kernel space and<br>
&gt; user space?<br>
&gt; If so, how is this done with the native API?<br>
&gt;<br>
&gt; The system has one real-time kernel process which communicates with other<br>
&gt; processes via shared memory.<br>
<br>
</div></div>See rt_mutex_bind:<br>
<a href="http://www.xenomai.org/documentation/branches/v2.4.x/html/api/group__mutex.html#g39b3a0e7f6f6ee41b8068ed59e25d1d1" target="_blank">http://www.xenomai.org/documentation/branches/v2.4.x/html/api/group__mutex.html#g39b3a0e7f6f6ee41b8068ed59e25d1d1</a><br>

or, for the posix skin, pthread_mutexattr_setpshared:<br>
<a href="http://www.xenomai.org/documentation/branches/v2.4.x/html/api/group__posix__mutex.html#g73bd8697b91e0ee9a63c30052ac9f72f" target="_blank">http://www.xenomai.org/documentation/branches/v2.4.x/html/api/group__posix__mutex.html#g73bd8697b91e0ee9a63c30052ac9f72f</a><br>

Note that for sharing a mutex with the posix skin, the pthread_mutex_t<br>
structure needs to reside on a shared memory.<br>
<br>
--<br>
<font color="#888888"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Gilles.<br>
<br>
</font></blockquote></div><br>

------=_Part_166757_20774957.1227225785600--

