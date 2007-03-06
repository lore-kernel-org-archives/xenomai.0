Message-ID: <b647ffbd0703061255p4c78d262n6a09c0b96661e9a5@domain.hid>
Date: Tue, 6 Mar 2007 21:55:14 +0100
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-help] process memory not locked
In-Reply-To: <38b44d590703061059x1ddc72aau9ead4838a7fa6cb7@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <38b44d590703060949lfa70769na93c19abd2ff248f@domain.hid>
	<45EDAB66.9070700@domain.hid> <45EDAD18.9080701@domain.hid>
	<38b44d590703061059x1ddc72aau9ead4838a7fa6cb7@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Saiful Khan <saiful.etc@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 06/03/07, Saiful Khan <saiful.etc@domain.hid> wrote:
> Hello,
>
> First of all thank you a lot. For the last several days I am getting lots of
> help from you. As well as I achived some positive results also. By the way
> my observation now is -
>
> mlockall is successfull
>  pthread_attr_init() - is successfull
> pthread_attr_setdetachstate() - successfull
> Here I am getting the message "Xenomai - process memory not locked (missing
> mlockall?) " and its stuck.

Do I understand ("stuck") right that the following pthread_create() is
never executed?

> pthread_create()  - this is returning nothing not success(0) nor failure.

Could you insert additional debugging lines in your code as shown
below and let us know of the outcome?

// btw does "attr" in your case allocated on stack?

pthread_attr_init(&attr);
printf("step 1\n");

memset(&attr, 0, sizeof(pthread_attr_t)); // <--- touch the "attr" here
printf("step 2\n")

pthread_attr_setdetachstate(&attr, ...);

printf("step 3\n");

pthread_create(.., &attr, ...);

So what's the last "step" printed?


-- 
Best regards,
Dmitry Adamushko

