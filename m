MIME-Version: 1.0
Sender: arungupta143@gmail.com
In-Reply-To: <5363D871.1020901@xenomai.org>
References: <53639F52.2070108@gmail.com>
	<5363D871.1020901@xenomai.org>
Date: Sun, 4 May 2014 07:45:53 +0530
Message-ID: <CAAE81mss=omVtBQ7a0qvk_Kwy+qsrV1=ymWR05GkMAJ+h_t7pQ@mail.gmail.com>
From: ARUN GUPTA <mail@arungupta.co.in>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Is everything inside a function(task wchi made as a
 RT_task) is comes under Realtime ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

Very Good morning.

Sorry for asking silly question.

I read both of the PDF's.

I was thinking that if i am trying to receive a certain level(1 ms) of
Response from a controller in a function.

My doubt is that

For Ex.
We have two task sets, Task 2's priority is lesser than task 1. I defined
both of the functions Ret_task


Task 1

Rt_task 1.1
Rt_task 1.2
Rt_task 1.3
Linux_Task 1.1
Linux Task 1.2
Rt_task 1.4
Rt_task .15


Task 2
Rt_task 2.1
Rt_task 2.2
Rt_task 2.3
Rt_task 2.4
Rt_task .2.5

Let's task 1 start first just after task 2 starts, when task reaches to
'Linux_Task 1.1' , task 2 preeempts to task and starts running  and after
completing the task 2, Task 1 resumes even task 1's, so task 1's response
time became higher due to linux_task in between. Is that right?  is this
happens? in this case

How should we design Xenomai task where Linux CALLs also included.

Please give some light on this situation.

and please suggest me a video tutorial for creating application using
xenomai

When a real=ADtime task in primary mode issues a regular Linux system call,
it is
immediately and transparently migrated by Xenomai to the Linux domain, sinc=
e
the operation could not be fulfilled into the Xenomai domain directly. At
that
point, the real=ADtime task re=ADenters the Linux kernel at the closest
rescheduling
point, and resumes the standard Linux system call procedure.



On Fri, May 2, 2014 at 11:10 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Le 02/05/2014 15:36, Arun Kumar Gupta a =E9crit :
> > Hello, I am new here,
> >
> > I want to know if i make a function(task) to real time,
> >
> > Is everything inside that function is in realtime scheduler or not ?
> > For Ex.
>
>
> http://www.xenomai.org/documentation/branches/v2.3.x/pdf/Life-with-Adeos-=
rev-B.pdf
>
> http://www.xenomai.org/documentation/branches/v2.3.x/pdf/Native-API-Tour-=
rev-C.pdf
>
> --
> Gilles.
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>



--=20
Regards

Arun Kumar Gupta
Find me on   <http://facebook.com/arungupta.co.in>
<https://twitter.com/arungupta2008>
  <http://www.linkedin.com/in/arungupta2008>
Contact  me : +91-8000597109
 Blog <http://arungupta.co.in/blog> | Blog @
Blogspo<http://arungupta1.blogspot.in/>t
| Myprofile <http://arungupta.co.in/blog/?page_id=3D2> | My
Research<http://arungupta.co.in/blog/?page_id=3D68>
mail@arungupta.co.in
