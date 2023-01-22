
int[] arr = { 7, 91, 64, 3, 38, 10, 6, 12, 5 };
int n = arr.Length;
radixSort(arr, n);


Console.ReadLine();

void radixSort(int[] arr, int n)
{
    int maxinum = arr.Max();
    int counter1 = 0;  //it tells how much digits does the maximum number has
    for(int i=0;(maxinum / 10) > 0; i++)
    {
        maxinum=maxinum / 10;
        counter1++;
    }

    for(int m=0; m<=counter1; m++)
    {
        int[] temparr1 = new int[n];
        for(int k=0; k<n; k++)
        {
            temparr1[k] = arr[k] / (int)Math.Pow(10, m) % 10; //getting the sepcific digits from right side. 
        }
        Console.WriteLine("the extracted digits are in following array...");
        printData(temparr1, temparr1.Length);

        for (int x = 0; x < n; x++)
         {
            for(int y=0;y<n-1;y++)
            { 
         	    if(temparr1[y]> temparr1[y+1])
         	    {
         		    int temp= temparr1[y];
                    temparr1[y]= temparr1[y+1];
                    temparr1[y+1]=temp;

                    int temp2 = arr[y];
                    arr[y] = arr[y + 1];
                    arr[y + 1] = temp2;
                }
            }

         }

        Console.WriteLine("the extracted digits sorted are as ...");
        printData(temparr1, temparr1.Length);
        Console.WriteLine("the arr modified is as follows...");
        printData(arr, arr.Length);
        Console.WriteLine("_________________________________________________");
    }
        
}
void printData(int[] arr, int n)
{
    for (int i = 0; i < n; i++)
    {
        Console.WriteLine(arr[i]);
    }
        
}
