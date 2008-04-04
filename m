Message-ID: <2ff1a98a0804040604x789518e6o15d33d5e934f36bf@domain.hid>
Date: Fri, 4 Apr 2008 15:04:27 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <7289437c0804040559u4deb2943m483ef6a6f78819a7@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <7289437c0804030246v7992ec23kedcc2c8b71dc14f8@domain.hid>
	<d6c8ef150804030300p3a4c719tca9903aa7663a5d9@domain.hid>
	<7289437c0804030552q79d1bb84jf5f40d1a57a443b5@domain.hid>
	<d6c8ef150804040018u1b4ed61eg6eccbf5257b88abf@domain.hid>
	<7289437c0804040559u4deb2943m483ef6a6f78819a7@domain.hid>
Subject: Re: [Xenomai-help] Question about rtdm_mmap_to_user()
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Perrine Martignoni <perrmart@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On Fri, Apr 4, 2008 at 2:59 PM, Perrine Martignoni <perrmart@domain.hid> wrote:
> >Except that the example listed in the document in question takes care of
> >defining the heap descriptor in global memory, not in the init_module()
> stack.
>
>
> It effectively works better with the RT_HEAP variable in global scope.
>
> I thought that the RT_HEAP variable was working like handles or descriptors
> in some RTOS where the life cycle of the descriptor is not correlated to the
> Os Object life cycle, that is to say:
>
>   => enter local scope           {
>                                   handle myHandle =
> CreateOsObject(x,y,z,&err);  // or err =  CreateOsObject(&myHandle,x,y,z);
>   => exit local scope             }
>
> When you go out of the local scope, you can no more use the handle (and then
> reference the created OS object ) because it was a local variable but the
> object created is still alive and will not be modified because the handle
> was declared on the stack. So I thought that the RT_HEAP variable was just a
> descriptor of a Heap object managed by xenomai but not the heap object
> itself.

The behaviour of the RT_HEAP descriptor is documented in
rt_heap_create documentation.

-- 
 Gilles

