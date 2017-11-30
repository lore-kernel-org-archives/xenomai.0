References: <CALLqZ8TWgsZAzRuYBQ1gd4s5KO_wO_aaY+UyVEMDBw5k9rSQqQ@mail.gmail.com>
 <4a34ed44-275f-ed3a-8548-33a6f1107ef7@xenomai.org>
 <CALLqZ8R=vaUDaWB+XGEdAeHg0O8uxxvtr7SYmYr=9+Mvq_6f5w@mail.gmail.com>
 <CALLqZ8QkQj7d_5BzMOcRhVi1fp2wzRZrJVKPxo7jnjODDpzNRw@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <6f681e15-3c6e-6b08-975a-f04cdc8c33ad@xenomai.org>
Date: Thu, 30 Nov 2017 09:50:37 +0100
MIME-Version: 1.0
In-Reply-To: <CALLqZ8QkQj7d_5BzMOcRhVi1fp2wzRZrJVKPxo7jnjODDpzNRw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Gpio-core question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 11/29/2017 09:40 PM, Greg Gallagher wrote:
> Hi,
>   Sorry for the formatting in the last email I'm not sure what
> happened in my editor.  I've had some time to look into this issue.
> For my case that is outlined above it looks like we insert the fd into
> the tree in create instance, then when we fail the call to
> dev->ops.open, the fd is cleaned up with linux by using put_unused_fd
> but we never remove it from the tree.  On the next call to open we get
> the same fd back from get_unused_fd_flags we then call create_instance
> and fail because that fd is already in the tree from the previous
> attempt.  I'll test out my theory tonight.  If this is what is
> happening should the fd be removed from the tree in cleanup_instance?
> I can play around with xnid_remove and see if working it into
> cleanup_instance will solve the issue.

You are definitely right. There should be an undo operation of
rtdm_fd_enter() in __rtdm_dev_open() or __rtdm_dev_socket(), in the
fail_open and fail_socket cases resp., along with dropping the file
context via cleanup_instance().

Another option might be to make the undoing useless, by postponing the
indexing until ->open() / ->socket() has returned successfully. To do
that, we would have to split rtdm_fd_enter() in two functional steps
instead of a single routine:

1- assign the default handlers, initializing the fd-> fields
2- index the rtdm_fd struct in the xntree.

Then, we would keep on doing (1) at the end of create_instance(),
waiting for the ->open() / ->socket() handler to return successfully
before doing (2).

I don't see any reason for ->open() or ->socket() to depend on the fact
that rtdm_fd is already indexed on the ufd, which is a user-space handle
anyway.

Do you want to take a stab at implementing that stuff?

-- 
Philippe.

