-module(triang).
-compile(export_all).

start() ->
	io:fwrite("\nClasificación de un triángulo por sus lados\n\n"),
	entrada().

entrada() ->
	A = pedirLado("A"),
	B = pedirLado("B"),
	C = pedirLado("C"),
	ValidT = validTri(A,B,C),
	if
		not ValidT ->
			io:fwrite("\tNo existe triángulo, debido a que la suma de los lados "),
			justificar(A,B,C),
			entrada();
		true ->
			tipo(A,B,C)
	end.

pedirLado(Letra) ->
	io:fwrite("Longitud de lado ~s: ",[Letra]),
	{ok,[SLado]} = io:fread("","~s"),
	ValN = validNum(SLado),

	if
		ValN > 0 ->
			case ValN of
				1 ->
					Num = list_to_integer(SLado);
				2 ->
					Num = list_to_float(SLado)
			end,
			if
				Num =< 0 ->
					io:fwrite("\tNo existe triángulo\n"),
					pedirLado(Letra);
				true ->
					Num
			end;
		true ->
			io:fwrite("\tSolo números\n"),
			pedirLado(Letra)
	end.

validTri(L1, L2, L3) ->
	if
		((L1 + L2 > L3) and (L2 + L3 > L1) and (L1 + L3 > L2)) ->
			true;
		true ->
			false
	end.

justificar(L1, L2, L3) ->
	if
		(L1 + L2 < L3) ->
			io:fwrite("A y B es menor al lado C");
		(L1 + L2 == L3) ->
			io:fwrite("A y B es igual al lado C");

		(L2 + L3 < L1) ->
			io:fwrite("B y C es menor al lado A");
		(L2 + L3 == L1) ->
			io:fwrite("B y C es igual al lado A");

		(L1 + L3 < L2) ->
			io:fwrite("A y C es menor al lado B");
		(L1 + L3 == L2) ->
			io:fwrite("A y C es igual al lado B");

		true ->
			0
	end,
	io:fwrite("\n\n").

validNum(S) ->
    Float = (catch list_to_float(S)),
    Int = (catch list_to_integer(S)),

    if
    	is_number(Int) ->
    		1;
    	is_number(Float) ->
    		2;
    	true ->
    		0
    end.

tipo(L1, L2, L3) ->
	if
		((L1 == L2) and (L2 == L3)) ->
			io:fwrite("\n\tEquilátero\n");
		((L1 /= L2) and (L1 /= L3) and (L2 /= L3)) ->
			io:fwrite("\n\tEscaleno\n");
		true ->
			io:fwrite("\n\tIsósceles\n")
	end.