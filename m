Message-ID: <458BB057.9090009@domain.hid>
Date: Fri, 22 Dec 2006 11:15:51 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <458ACFDA.8070300@domain.hid>	
	<25528819.1166701882755.JavaMail.ngmail@domain.hid>	
	<13574091.1166708188484.JavaMail.ngmail@domain.hid>	
	<1166710393.4960.13.camel@domain.hid>	
	<12420573.1166713240349.JavaMail.ngmail@domain.hid>	
	<b647ffbd0612210717u4b8f0505m65d01bc2824a144a@domain.hid>	
	<8403506.1166715370788.JavaMail.ngmail@domain.hid>	
	<b647ffbd0612210743m2b208cb2w6e9054336fd68028@domain.hid>	
	<9212697.1166778373331.JavaMail.ngmail@domain.hid>	
	<458BA432.2000205@domain.hid>
	<b647ffbd0612220140m504db8e4x52ca45477e425d44@domain.hid>
In-Reply-To: <b647ffbd0612220140m504db8e4x52ca45477e425d44@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Re: A fairly small rtnet/Xenomai...
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Dmitry Adamushko wrote:
> On 22/12/06, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> 
>>In absence of a better solution, I would recommend to use the "fault_vm"
>> function after each fork.
> 
> 
> But it's not safe. It doesn't stop any other rt threads (if there are
> a few in this app.) from touching the wp-pages (it's not only about
> stacks after all) in the mean time. So fault_vm() only increases the
> probability of not-crashing but doesn't eliminate it completely.
> 
> So all the contextes have to be blocked starting from the moment
> fork() is about to be called and till the moment a subsequent
> fault_vm() is done.
> It's ugly and that suggests fork() is not ok here at all.
> 
> And btw, vfork() should be a funny thing being called from
> multi-threaded app. It blocks a calling context and borrows its
> address space while other threads are continuing to run, well, with
> the same context (maybe it's handled somehow, have to check).

fault_vm is safe to use only if you are calling fork at a time when
there is only one thread. So, if your application is forking at init, it
should be OK.

-- 
                                                 Gilles Chanteperdrix

