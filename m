Subject: Re: [PATCH] utils/can: fix error handling, use errno instead of -ret
References: <240e9ca3-b532-1077-9b19-281a282312f6@grandegger.com>
 <fac6c5df-1ac2-4d66-48cb-5ed8db4da7f2@siemens.com>
From: Wolfgang Grandegger <wg@grandegger.com>
Message-ID: <7a4feb92-40ce-de29-b6c2-cb6f7ca72405@grandegger.com>
Date: Wed, 9 Oct 2019 10:32:55 +0200
MIME-Version: 1.0
In-Reply-To: <fac6c5df-1ac2-4d66-48cb-5ed8db4da7f2@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

Hello Jan,

Am 09.10.19 um 10:20 schrieb Jan Kiszka:
> On 09.10.19 09:36, Wolfgang Grandegger via Xenomai wrote:
>> For some reason, rtcansend and rtcanrecv test and evaluate the
>> return code of system functions instead of errno. This is wrong
>> and fixed with that commit.
>>
>> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
>> ---
>>
>> I was told that the error handling of the send/recv and similar
>> functions is incorrect and I can confirm that! In "rtcansend"
>> and "rtcanrecv", the negative return value is used as error
>> code instead of errno. Did the return code for the Xenomai POSIX
>> funtions change some time ago? If not, the bug was there since
>> the beginning, ouch!.
> 
> If the beginning of these tools was POSIX as well, I guess the issue was
> always there. OTOH, this uses native/alchemy for some services, and
> maybe the IO calls were native originally as well.
> 
> But there is some overshooting, see below.

Ah, right, the API was changed from the "native" to POSIX in 2014:

  utils/can: drop dependencies on obsolete rt_dev API

I'm going to fix the issue you mentioned below.

Thanks,

Wolfgang

>>
>> Wolfgang
>>
>>  utils/can/rtcanrecv.c | 30 +++++++++++++++---------------
>>  utils/can/rtcansend.c | 28 ++++++++++++++--------------
>>  2 files changed, 29 insertions(+), 29 deletions(-)
>>
>> diff --git a/utils/can/rtcanrecv.c b/utils/can/rtcanrecv.c
>> index 8155ab7..104ba25 100644
>> --- a/utils/can/rtcanrecv.c
>> +++ b/utils/can/rtcanrecv.c
>> @@ -63,7 +63,7 @@ static void cleanup(void)
>>  	ret = close(s);
>>  	s = -1;
>>  	if (ret) {
>> -	    fprintf(stderr, "close: %s\n", strerror(-ret));
>> +	    fprintf(stderr, "close: %s\n", strerror(errno));
>>  	}
>>  	exit(EXIT_SUCCESS);
>>      }
>> @@ -105,17 +105,17 @@ static void rt_task(void)
>>  	    ret = recvfrom(s, (void *)&frame, sizeof(can_frame_t), 0,
>>  				  (struct sockaddr *)&addr, &addrlen);
>>  	if (ret < 0) {
>> -	    switch (ret) {
>> -	    case -ETIMEDOUT:
>> +	    switch (errno) {
>> +	    case ETIMEDOUT:
>>  		if (verbose)
>> -		    printf("recv: timed out");
>> +		    printf("recv: timed out\n");
>>  		continue;
>> -	    case -EBADF:
>> +	    case EBADF:
>>  		if (verbose)
>> -		    printf("recv: aborted because socket was closed");
>> +		    printf("recv: aborted because socket was closed\n");
>>  		break;
>>  	    default:
>> -		fprintf(stderr, "recv: %s\n", strerror(-ret));
>> +		fprintf(stderr, "recv: %s\n", strerror(errno));
>>  	    }
>>  	    break;
>>  	}
>> @@ -234,7 +234,7 @@ int main(int argc, char **argv)
>>  
>>      ret = socket(PF_CAN, SOCK_RAW, CAN_RAW);
>>      if (ret < 0) {
>> -	fprintf(stderr, "socket: %s\n", strerror(-ret));
>> +	fprintf(stderr, "socket: %s\n", strerror(errno));
>>  	return -1;
>>      }
>>      s = ret;
>> @@ -254,7 +254,7 @@ int main(int argc, char **argv)
>>  
>>  	ret = ioctl(s, SIOCGIFINDEX, &ifr);
>>  	if (ret < 0) {
>> -	    fprintf(stderr, "ioctl GET_IFINDEX: %s\n", strerror(-ret));
>> +	    fprintf(stderr, "ioctl GET_IFINDEX: %s\n", strerror(errno));
>>  	    goto failure;
>>  	}
>>      }
>> @@ -263,7 +263,7 @@ int main(int argc, char **argv)
>>  	ret = setsockopt(s, SOL_CAN_RAW, CAN_RAW_ERR_FILTER,
>>  				&err_mask, sizeof(err_mask));
>>  	if (ret < 0) {
>> -	    fprintf(stderr, "setsockopt: %s\n", strerror(-ret));
>> +	    fprintf(stderr, "setsockopt: %s\n", strerror(errno));
>>  	    goto failure;
>>  	}
>>  	if (verbose)
>> @@ -275,7 +275,7 @@ int main(int argc, char **argv)
>>  				&recv_filter, filter_count *
>>  				sizeof(struct can_filter));
>>  	if (ret < 0) {
>> -	    fprintf(stderr, "setsockopt: %s\n", strerror(-ret));
>> +	    fprintf(stderr, "setsockopt: %s\n", strerror(errno));
>>  	    goto failure;
>>  	}
>>      }
>> @@ -285,7 +285,7 @@ int main(int argc, char **argv)
>>      ret = bind(s, (struct sockaddr *)&recv_addr,
>>  		      sizeof(struct sockaddr_can));
>>      if (ret < 0) {
>> -	fprintf(stderr, "bind: %s\n", strerror(-ret));
>> +	fprintf(stderr, "bind: %s\n", strerror(errno));
>>  	goto failure;
>>      }
>>  
>> @@ -294,7 +294,7 @@ int main(int argc, char **argv)
>>  	    printf("Timeout: %lld ns\n", (long long)timeout);
>>  	ret = ioctl(s, RTCAN_RTIOC_RCV_TIMEOUT, &timeout);
>>  	if (ret) {
>> -	    fprintf(stderr, "ioctl RCV_TIMEOUT: %s\n", strerror(-ret));
>> +	    fprintf(stderr, "ioctl RCV_TIMEOUT: %s\n", strerror(errno));
>>  	    goto failure;
>>  	}
>>      }
>> @@ -302,7 +302,7 @@ int main(int argc, char **argv)
>>      if (with_timestamp) {
>>  	ret = ioctl(s, RTCAN_RTIOC_TAKE_TIMESTAMP, RTCAN_TAKE_TIMESTAMPS);
>>  	if (ret) {
>> -	    fprintf(stderr, "ioctl TAKE_TIMESTAMP: %s\n", strerror(-ret));
>> +	    fprintf(stderr, "ioctl TAKE_TIMESTAMP: %s\n", strerror(errno));
>>  	    goto failure;
>>  	}
>>      }
>> @@ -310,7 +310,7 @@ int main(int argc, char **argv)
>>      snprintf(name, sizeof(name), "rtcanrecv-%d", getpid());
>>      ret = rt_task_shadow(&rt_task_desc, name, 0, 0);
>>      if (ret) {
>> -	fprintf(stderr, "rt_task_shadow: %s\n", strerror(-ret));
>> +	fprintf(stderr, "rt_task_shadow: %s\n", strerror(errno));
> 
> This is alchemy API, and that one does not use errno.
> 
>>  	goto failure;
>>      }
>>  
>> diff --git a/utils/can/rtcansend.c b/utils/can/rtcansend.c
>> index 4a692b3..8240531 100644
>> --- a/utils/can/rtcansend.c
>> +++ b/utils/can/rtcansend.c
>> @@ -58,7 +58,7 @@ static void cleanup(void)
>>  	ret = close(s);
>>  	s = -1;
>>  	if (ret) {
>> -	    fprintf(stderr, "close: %s\n", strerror(-ret));
>> +	    fprintf(stderr, "close: %s\n", strerror(errno));
>>  	}
>>  	exit(EXIT_SUCCESS);
>>      }
>> @@ -87,17 +87,17 @@ static void rt_task(void)
>>  	    ret = sendto(s, (void *)&frame, sizeof(can_frame_t), 0,
>>  				(struct sockaddr *)&to_addr, sizeof(to_addr));
>>  	if (ret < 0) {
>> -	    switch (ret) {
>> -	    case -ETIMEDOUT:
>> +	    switch (errno) {
>> +	    case ETIMEDOUT:
>>  		if (verbose)
>> -		    printf("send(to): timed out");
>> +		    printf("send(to): timed out\n");
>>  		break;
>> -	    case -EBADF:
>> +	    case EBADF:
>>  		if (verbose)
>> -		    printf("send(to): aborted because socket was closed");
>> +		    printf("send(to): aborted because socket was closed\n");
>>  		break;
>>  	    default:
>> -		fprintf(stderr, "send: %s\n", strerror(-ret));
>> +		fprintf(stderr, "send: %s\n", strerror(errno));
>>  		break;
>>  	    }
>>  	    i = loops;		/* abort */
>> @@ -215,7 +215,7 @@ int main(int argc, char **argv)
>>  
>>      ret = socket(PF_CAN, SOCK_RAW, CAN_RAW);
>>      if (ret < 0) {
>> -	fprintf(stderr, "socket: %s\n", strerror(-ret));
>> +	fprintf(stderr, "socket: %s\n", strerror(errno));
>>  	return -1;
>>      }
>>      s = ret;
>> @@ -224,7 +224,7 @@ int main(int argc, char **argv)
>>  	ret = setsockopt(s, SOL_CAN_RAW, CAN_RAW_LOOPBACK,
>>  				&loopback, sizeof(loopback));
>>  	if (ret < 0) {
>> -	    fprintf(stderr, "setsockopt: %s\n", strerror(-ret));
>> +	    fprintf(stderr, "setsockopt: %s\n", strerror(errno));
>>  	    goto failure;
>>  	}
>>  	if (verbose)
>> @@ -237,7 +237,7 @@ int main(int argc, char **argv)
>>  
>>      ret = ioctl(s, SIOCGIFINDEX, &ifr);
>>      if (ret < 0) {
>> -	fprintf(stderr, "ioctl: %s\n", strerror(-ret));
>> +	fprintf(stderr, "ioctl: %s\n", strerror(errno));
>>  	goto failure;
>>      }
>>  
>> @@ -248,13 +248,13 @@ int main(int argc, char **argv)
>>  	/* Suppress definiton of a default receive filter list */
>>  	ret = setsockopt(s, SOL_CAN_RAW, CAN_RAW_FILTER, NULL, 0);
>>  	if (ret < 0) {
>> -	    fprintf(stderr, "setsockopt: %s\n", strerror(-ret));
>> +	    fprintf(stderr, "setsockopt: %s\n", strerror(errno));
>>  	    goto failure;
>>  	}
>>  
>>  	ret = bind(s, (struct sockaddr *)&to_addr, sizeof(to_addr));
>>  	if (ret < 0) {
>> -	    fprintf(stderr, "bind: %s\n", strerror(-ret));
>> +	    fprintf(stderr, "bind: %s\n", strerror(errno));
>>  	    goto failure;
>>  	}
>>      }
>> @@ -282,7 +282,7 @@ int main(int argc, char **argv)
>>  	    printf("Timeout: %lld ns\n", (long long)timeout);
>>  	ret = ioctl(s, RTCAN_RTIOC_SND_TIMEOUT, &timeout);
>>  	if (ret) {
>> -	    fprintf(stderr, "ioctl SND_TIMEOUT: %s\n", strerror(-ret));
>> +	    fprintf(stderr, "ioctl SND_TIMEOUT: %s\n", strerror(errno));
>>  	    goto failure;
>>  	}
>>      }
>> @@ -290,7 +290,7 @@ int main(int argc, char **argv)
>>      snprintf(name, sizeof(name), "rtcansend-%d", getpid());
>>      ret = rt_task_shadow(&rt_task_desc, name, 1, 0);
>>      if (ret) {
>> -	fprintf(stderr, "rt_task_shadow: %s\n", strerror(-ret));
>> +	fprintf(stderr, "rt_task_shadow: %s\n", strerror(errno));
> 
> Same as above.
> 
>>  	goto failure;
>>      }
>>  
>>
> 
> Jan
> 

